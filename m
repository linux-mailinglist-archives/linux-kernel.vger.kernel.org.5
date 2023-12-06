Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CA747807C5A
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Dec 2023 00:32:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1441796AbjLFXcO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Dec 2023 18:32:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38008 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1379687AbjLFXcN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Dec 2023 18:32:13 -0500
Received: from mail-wm1-x342.google.com (mail-wm1-x342.google.com [IPv6:2a00:1450:4864:20::342])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 31FB1A9
        for <linux-kernel@vger.kernel.org>; Wed,  6 Dec 2023 15:32:19 -0800 (PST)
Received: by mail-wm1-x342.google.com with SMTP id 5b1f17b1804b1-40c0e7b8a9bso4852635e9.3
        for <linux-kernel@vger.kernel.org>; Wed, 06 Dec 2023 15:32:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1701905537; x=1702510337; darn=vger.kernel.org;
        h=mime-version:user-agent:references:message-id:in-reply-to:subject
         :cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=FhmB80cZyzkXTbAuvFBPao9VdOjBS6zAfo3w2wC8nJI=;
        b=YvEXVo4yZaXjxC8OPvVppXNuxfsgT4sKgFW9ufBhy307N1A9Q2OnqCdtmD5YdgM8wP
         WGJIDykL9vidLLEkcESIwfDGNGG1+EG9F6QlvWN1KWPPoavUZBCHn3+J9+AxmKSNIPzs
         6uG5DpJS1G+jkWk9c+uygu/5/vfKBGtQMpgUmsCHKzpze1EjUXLPru3sGBAlBQC05UFO
         IYW/+YCO0OV1iM5ZA2k+CODcYcxt9pppv2NS45uC7OG1xDtI3ymmgezvAkvbYl48m893
         2P060lUNBcntSm0m09JMeD5T9rI/uufSJR/bWi2WHBbfs2UFztxeZYhXmSbj0ldMHnSz
         0yeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701905537; x=1702510337;
        h=mime-version:user-agent:references:message-id:in-reply-to:subject
         :cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FhmB80cZyzkXTbAuvFBPao9VdOjBS6zAfo3w2wC8nJI=;
        b=uFuyEVQreGejT2+pOJIbuMcEFiIpHvA6cdkbSn5y8qMn1QT2Pcev7unaFEmN84vCfm
         mLWzs3DXfItnQa+6UcCCg6EJCyb3eZpelOy+NCs494WysmZETMyyrgAN4hA3dDaPj811
         hEU1JY+F6/xipl0EwBr4vYo8qDybSwUPFNvSi3B34Sn6G1HHaPgNh6Zl5GEWjBe0BgmY
         79JsnlhCLeqE1mm2iRbw2ycLsQnG/DiSRI1ZY8VS/BiMXb4n4vEuok2dQhpmD9PSFuGz
         HkkgZMFDmBDRUsivC0n1ZA8/Iqi3ccXL+mx/px52nwaBhlaGFMf3sKc6WTtVPBVQaTrj
         lr5Q==
X-Gm-Message-State: AOJu0YxvjKVP3R7etO7/sQMmMoutqC2WHE5Gw+kGUumdblbHo1alHiV/
        HltDk8qO99YdhJUffRlvwEuBTFoquOdfnavHH9yDg3jl
X-Google-Smtp-Source: AGHT+IGIgnV3BoRr41B2+O2ZrJOMKZZ6pkZGjZ2WZi3Wn8K2asMEsGUUIVj0kMRVkT1DbM0qb+as5w==
X-Received: by 2002:a05:600c:1ca6:b0:40b:5e21:dd2a with SMTP id k38-20020a05600c1ca600b0040b5e21dd2amr1006878wms.88.1701905537666;
        Wed, 06 Dec 2023 15:32:17 -0800 (PST)
Received: from localhost ([193.86.92.180])
        by smtp.gmail.com with ESMTPSA id u21-20020a05600c139500b0040839fcb217sm1062847wmf.8.2023.12.06.15.32.17
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 06 Dec 2023 15:32:17 -0800 (PST)
From:   Jiri Kosina <jkosina@suse.com>
X-Google-Original-From: Jiri Kosina <jikos@kernel.org>
Date:   Thu, 7 Dec 2023 00:32:17 +0100 (CET)
To:     Benjamin Tissoires <bentiss@kernel.org>
cc:     Benjamin Tissoires <benjamin.tissoires@redhat.com>,
        Shuah Khan <shuah@kernel.org>,
        Peter Hutterer <peter.hutterer@who-t.net>,
        linux-input@vger.kernel.org, linux-kselftest@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 00/15] selftests/hid: tablets fixes
In-Reply-To: <20231206-wip-selftests-v2-0-c0350c2f5986@kernel.org>
Message-ID: <nycvar.YFH.7.76.2312070031210.29220@cbobk.fhfr.pm>
References: <20231206-wip-selftests-v2-0-c0350c2f5986@kernel.org>
User-Agent: Alpine 2.21 (LSU 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 6 Dec 2023, Benjamin Tissoires wrote:

> Hi,
> 
> the main trigger of this series was the XP-Pen issue[0].
> Basically, the tablets tests were good-ish but couldn't
> handle that tablet both in terms of emulation or in terms
> of detection of issues.
> 
> So rework the tablets test a bit to be able to include the
> XP-Pen patch later, once I have a kernel fix for it (right
> now I only have a HID-BPF fix, meaning that the test will
> fail if I include them).
> 
> Also, vmtest.sh needed a little bit of care, because
> boot2container moved, and I made it easier to reuse in a CI
> environment.
> 
> Cheers,
> Benjamin
> 
> Note: I got the confirmation off-list from Peter that his
> rev-by applied to the whole series.
> 
> [0] https://lore.kernel.org/all/nycvar.YFH.7.76.2311012033290.29220@cbobk.fhfr.pm/
> 
> Signed-off-by: Benjamin Tissoires <bentiss@kernel.org>

FWIW

	Acked-by: Jiri Kosina <jkosina@suse.com>

As far as I am concerned, feel free to push it to hid.git right away. And 
thanks a lot for all the work.

-- 
Jiri Kosina
SUSE Labs

