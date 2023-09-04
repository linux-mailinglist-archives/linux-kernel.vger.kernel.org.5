Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CD732791615
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Sep 2023 13:11:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349665AbjIDLLd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Sep 2023 07:11:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48242 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229980AbjIDLLc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Sep 2023 07:11:32 -0400
Received: from mail-pf1-x434.google.com (mail-pf1-x434.google.com [IPv6:2607:f8b0:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 84F461AD;
        Mon,  4 Sep 2023 04:11:29 -0700 (PDT)
Received: by mail-pf1-x434.google.com with SMTP id d2e1a72fcca58-68a402c1fcdso707634b3a.1;
        Mon, 04 Sep 2023 04:11:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1693825889; x=1694430689; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:references:cc:to:from
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=VfLBqtqsKewVLZ7LDcXD0Gsn2qEn+ss4iL3ZMurcTxk=;
        b=bibu4mPjfRh5IPg1nwWoymztXmT2z2oYkW9fwPkJ0GKVIicXFrUDe0rSo6jvJ7o92r
         SO0Vk3TNysD3FmE4qHq5noROtBZb4pwpELPaYE//aSpDiD4fmSL8NDN+cdF7WTEw8ImY
         /RumMl5pc3yr34MH6ac3MkEZfyWFPi1rtVCjs6PQXXCBKSmlMeV3TMVl1Tm2ZbA1vlA+
         0tYK0OilRxeEqFHzYUS9eYF9bgzg4vwQEUMyc4/X7DZUJXcv5lhAsR7arDG1pOKYN91v
         iFAP5ykSd+7e7025eNouG6kieQB++QmmWXBSQG8pEOE3wCAzLo1i0kKMGxe+yttLC9jr
         Sw1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693825889; x=1694430689;
        h=content-transfer-encoding:in-reply-to:references:cc:to:from
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=VfLBqtqsKewVLZ7LDcXD0Gsn2qEn+ss4iL3ZMurcTxk=;
        b=PQo2zQEGxiFU6t9iviMSnrms6uMPZ3kfOW8Wf6+SETlYzlUWoCJQi3P61gXiyIZC3/
         Ar3SL4goITQqcogGVk9wjftNRfLmt9qfMN+o8jBhd96cEQJM6t2+tahbMcjRyfz7V9uQ
         GNv++ucYDKUxoyz08eqaZ0soKZIQzMObg0KmeSLwEmjMRlZ8DaROreM5lUwoOZENe8I1
         wz4kBg5ielvbRe41Uh5V1HHAvhDHRAEfQuvH6jmKQ7ydt9zv0y67m1NY+LeV9pr6gWTC
         ySiiwDKI5nKjqIDibQXS16c9HhZj93PcTjWW23dkUxa7wKYOlDa1MUFWC0mSayyQicaM
         1l+g==
X-Gm-Message-State: AOJu0YzklY12NQ4VQzf+OaSCjJejBkaO3xxe25flc0TrDbB0VwzY6LE+
        eU+c6K0dBHCI5hZTwHcsJTs=
X-Google-Smtp-Source: AGHT+IGhVcxbTJAKxk/tRr/+FBgRNMp49OEhYj+pugMQgSKYjV7TBH7c1h9wwQ0MwzKbY+MoacCkow==
X-Received: by 2002:a05:6a00:1587:b0:68c:4ff1:3dfb with SMTP id u7-20020a056a00158700b0068c4ff13dfbmr10008646pfk.8.1693825888906;
        Mon, 04 Sep 2023 04:11:28 -0700 (PDT)
Received: from [192.168.0.106] ([103.124.138.83])
        by smtp.gmail.com with ESMTPSA id x26-20020aa784da000000b0064d57ecaa1dsm7155897pfn.28.2023.09.04.04.11.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 04 Sep 2023 04:11:28 -0700 (PDT)
Message-ID: <79b1e941-b0a1-1b69-0f2e-38f2949ed37a@gmail.com>
Date:   Mon, 4 Sep 2023 18:11:22 +0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.0
Subject: Re: Fwd: Kernel version 6.1.50 regression: radeonfb deactivate vga
 console
Content-Language: en-US
From:   Bagas Sanjaya <bagasdotme@gmail.com>
To:     Daniel Vetter <daniel.vetter@ffwll.ch>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Helge Deller <deller@gmx.de>,
        Alexei Gradinari <alex2grad@gmail.com>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Regressions <regressions@lists.linux.dev>,
        Linux Framebuffer <linux-fbdev@vger.kernel.org>,
        Linux DRI Development <dri-devel@lists.freedesktop.org>
References: <f8c26878-aabc-7cc9-59a1-3f68bf1d43c1@gmail.com>
In-Reply-To: <f8c26878-aabc-7cc9-59a1-3f68bf1d43c1@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 02/09/2023 07:01, Bagas Sanjaya wrote:
> #regzbot introduced: 9b539c4d1b921b https://bugzilla.kernel.org/show_bug.cgi?id=217861
> #regzbot title: using pci aperture helpers deactivates AMD ES1000 VGA controller
> 

#regzbot inconclusive: now tracked on gitlab.freedesktop.org tracker
#regzbot link: https://gitlab.freedesktop.org/drm/amd/-/issues/2826

Thanks.

-- 
An old man doll... just what I always wanted! - Clara

