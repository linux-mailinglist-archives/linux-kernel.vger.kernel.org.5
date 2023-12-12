Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C375180EF86
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Dec 2023 16:01:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376446AbjLLPBg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Dec 2023 10:01:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44030 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1376378AbjLLPBe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Dec 2023 10:01:34 -0500
Received: from mail-io1-xd35.google.com (mail-io1-xd35.google.com [IPv6:2607:f8b0:4864:20::d35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6451CE3
        for <linux-kernel@vger.kernel.org>; Tue, 12 Dec 2023 07:01:40 -0800 (PST)
Received: by mail-io1-xd35.google.com with SMTP id ca18e2360f4ac-7b7684f0fe4so5612839f.1
        for <linux-kernel@vger.kernel.org>; Tue, 12 Dec 2023 07:01:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1702393299; x=1702998099; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ang1nCl8Jm3Jnw0Trx7aK3jW0jOvkSmS0o2JfMszURQ=;
        b=1VxMqQ0q4oKfsDaWkCDW/gHHGvaVbuLmRGyxPTy+GK8qECb39MOJL72AhfPDowL63r
         hf3xZqRDyI63uuoA/GQUjHjfD8Y3UfHG6/MMWow52LiGpIIFtd6k6541uUzBDA0iCFzC
         PyJNxHr61TfeRhr049EiG2e/5GARumbCkhjRiOvgylt36wy7NwRUfr56Eqlv4Qce11Wm
         Y6ojGJgHSFKmzP33xrc3rbMklTpd2i+yBMB2jmQLwjoLyvauyGUhO8RjhaamaIaSNHxK
         4nu9KiklWnTSCg5k/bObRmRNaAfrTaJ6IVTUaUukQRvUkAzAPNyB/0r6x1137lYDWWSq
         kUuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702393299; x=1702998099;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ang1nCl8Jm3Jnw0Trx7aK3jW0jOvkSmS0o2JfMszURQ=;
        b=eoog1YSdH3eWFc4WXXWfoJ/lLlrfHXt3/C3WHaaanSztf8iXRIB12Km9jk0fAhpRDb
         +zT/1/MSCcOzKyLAH6SAXNY3Vj4yClKgYxcOI0qMCGwmCjcZccITT+73UZ32T/MSS+2X
         qWZ414uLEKTvjywvMru/YT7yolV+Qz2D4mbT4YoWzpUVC9NVXu7OXy6cj5mQDunJuFgy
         slN/JwvK0WSt6WnH1dV4Ksoj2QKOQzT7zUaYLsdHZ1W3/o2hLpbL/Gf7ZMI1kH9ymkB6
         czg7bQvMSy8CLu6tET2iV9UfTwOCZTVCotGexzBvxGUPsvIT89s5iwVjgBvtk/SDnRCm
         XcBg==
X-Gm-Message-State: AOJu0YzvBNiXqVI917dkUxucxcOCJb533LOHdt4ljUgOhyJvaVyyDREo
        puq+HsSkymc+9ZiFFlH07CPkF/E6EnmgMZyUx6/yVw==
X-Google-Smtp-Source: AGHT+IH7qpx1lIvuIeLGtBhMoJA4VKjS5ZY5BsCzE5SvxLi+0WSdlLyvXuj64P1RhEVFHgnEwds6FQ==
X-Received: by 2002:a92:cd82:0:b0:35d:7a37:5236 with SMTP id r2-20020a92cd82000000b0035d7a375236mr11505131ilb.2.1702393299512;
        Tue, 12 Dec 2023 07:01:39 -0800 (PST)
Received: from [192.168.1.116] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id h17-20020a056e021d9100b0035d3be59977sm2942369ila.85.2023.12.12.07.01.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 12 Dec 2023 07:01:39 -0800 (PST)
Message-ID: <b203a609-1f5e-4d1f-861b-c252ea164c99@kernel.dk>
Date:   Tue, 12 Dec 2023 08:01:38 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: linux-next: duplicate patches in the block tree
Content-Language: en-US
To:     Christian Brauner <brauner@kernel.org>,
        Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
References: <20231212130213.631140dd@canb.auug.org.au>
 <20231212-innung-zuber-2f10bcffac51@brauner>
From:   Jens Axboe <axboe@kernel.dk>
In-Reply-To: <20231212-innung-zuber-2f10bcffac51@brauner>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/12/23 6:38 AM, Christian Brauner wrote:
> On Tue, Dec 12, 2023 at 01:02:13PM +1100, Stephen Rothwell wrote:
>> Hi all,
>>
>> The following commits are also in the vfs-brauner tree as different
>> commits (but the same patches):
> 
> Thanks, Stephen. I gave Jens a stable vfs.file branch that he can pull
> into his so this shouldn't become an issue again.

Should be clean now, rebased with the stable branch pulled in first.

-- 
Jens Axboe


