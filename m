Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5BD02789B10
	for <lists+linux-kernel@lfdr.de>; Sun, 27 Aug 2023 04:51:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229817AbjH0CvJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 26 Aug 2023 22:51:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50326 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229831AbjH0Cux (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 26 Aug 2023 22:50:53 -0400
Received: from mail-qt1-x835.google.com (mail-qt1-x835.google.com [IPv6:2607:f8b0:4864:20::835])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 61FD4FA;
        Sat, 26 Aug 2023 19:50:51 -0700 (PDT)
Received: by mail-qt1-x835.google.com with SMTP id d75a77b69052e-41095b84d8eso13897451cf.2;
        Sat, 26 Aug 2023 19:50:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1693104650; x=1693709450;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=MIw9Q5r09NfZUTqarX7Iy/jkPLDDRLQ9DQT1RqFnR3Y=;
        b=kOl2hRWSxWCriLB9sFGb002Zaoa8KZGxKdfMb4QBHLderLFmnWMv7HAY9oKY2hgPt3
         rsCsEvkVqdTi+qJGudo1xbfiMGoDNtmKO2scFOdew5c1otjzENK/Jphlk3lGqgubR+ho
         SbPAbptbz2slPYs4PppPNc/dm+0UDentv8R+hO8eqO6/3sNKWO0CkX/aLpT8pRVSPdV7
         C8rGQUcU3A9Jwth5rUbxnckXtpkmtp4TOu51+QEwcc7D1n9h1WDhHteFjyGuZtWJqAyU
         PERGSnFnDvJz0Mpv6gq6snSpTJIymm5IE976PQYsw56M6/S+oddNSLSLbY/6ajehopjj
         mdTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693104650; x=1693709450;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=MIw9Q5r09NfZUTqarX7Iy/jkPLDDRLQ9DQT1RqFnR3Y=;
        b=KTNygRfXvJeUraqBrV1DPaQNYFjmcT3F9oVAEn1MHT9HRdi5Rwwf2uv1TgqNmeVryn
         s493sWbz8tYlV0FAm4usMRCeJRGr1K4EVKJnHdg7oHZKnoGFHRqzMLe9y+8djBjspVKc
         XDQ9zZp9xuSMoqhMczhzvJrodLlR2EkmP7/p0YwY4Wz5n5QRLS4h/yXKHONGehe6OKhA
         Y0jL3tK/pVMdI9BlMpPZH/MccE8PEBhqN8x/WV9AlPc9t8HQ75aIUqRAwOVSHUx9S4nK
         TCQJlK/QHZesZwbjAr2vKeRQ02OtfVKUBJoqWHgI69PCpzIwVu4kYE0+RuoLPfgtbFcd
         F9Kw==
X-Gm-Message-State: AOJu0YxEZ7WECboiXq1CZae15lxc/6CbrTKISQdiPdYAKVkOzoU9llnO
        J9vyH8lAy8b0wXxlxfvMPHfL8Lxe0rA=
X-Google-Smtp-Source: AGHT+IFKtR6ptyowRAiBmNvqL6eepFITkIOnRdFz5KyEAkPiJJqcLS3WFsT7VTVVAbWOSGjuSpue0Q==
X-Received: by 2002:ac8:5909:0:b0:403:c687:bfbb with SMTP id 9-20020ac85909000000b00403c687bfbbmr25298335qty.1.1693104650429;
        Sat, 26 Aug 2023 19:50:50 -0700 (PDT)
Received: from [192.168.0.105] ([103.124.138.83])
        by smtp.gmail.com with ESMTPSA id u7-20020a17090341c700b001bdb8f757besm4440223ple.23.2023.08.26.19.50.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 26 Aug 2023 19:50:49 -0700 (PDT)
Message-ID: <e644366b-8387-c228-78cb-f108453b0b1d@gmail.com>
Date:   Sun, 27 Aug 2023 09:50:46 +0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.14.0
Subject: Re: Cache coherency bug: stale reads on /dev/sda1
Content-Language: en-US
To:     Joshua Hudson <joshudson@gmail.com>,
        Al Viro <viro@zeniv.linux.org.uk>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux IDE and libata <linux-ide@vger.kernel.org>,
        Hans de Goede <hdegoede@redhat.com>,
        Jens Axboe <axboe@kernel.dk>,
        Damien Le Moal <dlemoal@kernel.org>,
        OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
References: <CA+jjjYTk=5wn2o46uNB+bJYX8xLgMP==dsJuvC94DvtN2f_6Yw@mail.gmail.com>
 <ZOqg9VovoVanfuR0@debian.me>
 <CA+jjjYT6+NJwB2Kn0jWLKtmz3dWH6UnVJNA6vDbPXnnJnHMf9Q@mail.gmail.com>
 <20230827020635.GQ3390869@ZenIV>
 <CA+jjjYRr3SHvXhVZLfACkUrN98n3W8aMBe1e8zqUNDuRZt17=A@mail.gmail.com>
From:   Bagas Sanjaya <bagasdotme@gmail.com>
In-Reply-To: <CA+jjjYRr3SHvXhVZLfACkUrN98n3W8aMBe1e8zqUNDuRZt17=A@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 27/08/2023 09:38, Joshua Hudson wrote:
> "Whole disk and all partitions have page caches of their own."
> 
> That's so bad.
> 
> I can think of numerous cases where this will cause problems; including
> some I encountered last year and did not understand at the time. Manipulating
> EFI partitions through the whole disk device makes sense because FAT filesystems
> *know their offset on the disk*, and some of the existing tools really
> don't like being
> given a partition device.
> 
> There's also the astounding: write stuff to disk, umount everything,
> copy one disk to
> another using the whole disk device doesn't work because reading the whole disk
> yields a stale cache (sometimes).
> 
> On the other hand, I can think of very few cases where the file vs
> disk buffer pool
> matters, because the loop device is unaffected (writing to a loop
> block device is
> coherent with the file).
> 

tl;dr:

> A: http://en.wikipedia.org/wiki/Top_post
> Q: Were do I find info about this thing called top-posting?
> A: Because it messes up the order in which people normally read text.
> Q: Why is top-posting such a bad thing?
> A: Top-posting.
> Q: What is the most annoying thing in e-mail?
> 
> A: No.
> Q: Should I include quotations after my reply?
> 
> http://daringfireball.net/2007/07/on_top

What cases on the loop devices?

-- 
An old man doll... just what I always wanted! - Clara

