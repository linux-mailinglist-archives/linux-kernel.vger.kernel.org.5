Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 27DB7805658
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Dec 2023 14:47:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345517AbjLENq5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Dec 2023 08:46:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55424 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345492AbjLENqz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Dec 2023 08:46:55 -0500
Received: from mail-pf1-x431.google.com (mail-pf1-x431.google.com [IPv6:2607:f8b0:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 06A9F19F
        for <linux-kernel@vger.kernel.org>; Tue,  5 Dec 2023 05:47:00 -0800 (PST)
Received: by mail-pf1-x431.google.com with SMTP id d2e1a72fcca58-6ce6d089482so115457b3a.0
        for <linux-kernel@vger.kernel.org>; Tue, 05 Dec 2023 05:47:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1701784020; x=1702388820; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=5vhET9uYAxaYFv0iZJAAZ2wIjGaityUIytxO36nZyqc=;
        b=2g2t4duPMog8byhY9+CTutJUomlW/v3Bxj4n89wo2FR3tyKHoDitRXns36kdGAR9WU
         65XpreGUQxWlSRTH3ybhVRdsVp7ONwVLOZIt6LyByPVENln93R1XQOKXFdI5IC+TlE3I
         Wzwf5rekx4DHVanQvMMyNiu2BHBR19vTpG3rlJZFP43ii1arryWIcyS0yauNVm3ubeov
         YKDGC8cw5WW7gHO4lYwUu0xNP0y64dMZvWB6vwC4wFMz+szBoTV9lZ2QpZUbXJynZMyu
         wENwyMR2yt/Fgwnp3gI8ulIXqkvuXPr2W4NbmJ8/F0zPJwFsEUjfscyM1XmNKXnK9iGB
         ewFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701784020; x=1702388820;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=5vhET9uYAxaYFv0iZJAAZ2wIjGaityUIytxO36nZyqc=;
        b=BkPISX7S6Tsgcv8NBvM1+9/7fTUSfP9/yJsHIlWUrn+ScuCK9l53SNUw+mwS3AbcFg
         kHkzoh8u3dVluMfngQZK6MgM9EZt54b62yzCoX+lE/QTis8NgUkKNdBZa0/UXWiKsrR5
         sRbJrrDdvMlXvnYRDpEpZ24DNJgeNbCG7fHpHJK/tB6kwpYUFUluLmipPBKbtEiFPEWc
         BdiD9EExLOKPd6r1AK2IPObLEmVrQ0hf4vCZkCVp/Ty9D8UNCPgw2OtOFcX0rRLUQqHt
         Kb8CkqskffWZqa+N+Rybc1mSZwBws4D7dSVBNoHhXreSh56FyM88VmmlrFegbG3U6eTA
         6qFw==
X-Gm-Message-State: AOJu0Yxbh82Axq7/tmt1IOypupBPQmlqjOWjGDIOq7+kYvEI8Z0RBMIx
        yFsxbCx+1UB/Cemmtb4IXwqodh0f5BFpTkboQuyLSQ==
X-Google-Smtp-Source: AGHT+IGirGijGAl96D7hz7jexl1yFqfDwEFdeaBchjoEVH2o1dSvk/pdXpgkmP2M/V0NY1USFx7yuQ==
X-Received: by 2002:a05:6a21:9983:b0:185:a0eb:8574 with SMTP id ve3-20020a056a21998300b00185a0eb8574mr19293737pzb.5.1701784020102;
        Tue, 05 Dec 2023 05:47:00 -0800 (PST)
Received: from [192.168.1.150] ([198.8.77.194])
        by smtp.gmail.com with ESMTPSA id a12-20020a63e40c000000b0059cc2f1b7basm9237873pgi.11.2023.12.05.05.46.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 05 Dec 2023 05:46:59 -0800 (PST)
Message-ID: <8562f120-13f2-473c-9024-a4c5996fd5e3@kernel.dk>
Date:   Tue, 5 Dec 2023 06:46:58 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCHSET 0/2] Get rid of import_single_range()
To:     Christian Brauner <brauner@kernel.org>
Cc:     linux-kernel@vger.kernel.org, viro@zeniv.linux.org.uk
References: <20231204174827.1258875-1-axboe@kernel.dk>
 <20231205-kaminholz-halstuch-280db992267b@brauner>
Content-Language: en-US
From:   Jens Axboe <axboe@kernel.dk>
In-Reply-To: <20231205-kaminholz-halstuch-280db992267b@brauner>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/5/23 3:57 AM, Christian Brauner wrote:
> On Mon, Dec 04, 2023 at 10:47:48AM -0700, Jens Axboe wrote:
>> Hi,
>>
>> While looking at this today, I noticed that the 'iov' argument to this
>> function is totally dead code. Patch 1 gets rid of it, and with this
>> function and import_ubuf() now being identical, converts the callers
>> to just use import_ubuf().
>>
>> No functional changes here, just a cleanup removing some dead code.
> 
> Looks good. I've picked this up into vfs.iov_iter but let me know if
> you're already carrying this.

That's fine thanks, I don't have them stashed anywhere.

-- 
Jens Axboe


