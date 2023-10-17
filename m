Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 54E467CCDCF
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Oct 2023 22:20:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234424AbjJQUUe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Oct 2023 16:20:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48460 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229848AbjJQUUc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Oct 2023 16:20:32 -0400
Received: from mail-qk1-x72d.google.com (mail-qk1-x72d.google.com [IPv6:2607:f8b0:4864:20::72d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 848EB92
        for <linux-kernel@vger.kernel.org>; Tue, 17 Oct 2023 13:20:28 -0700 (PDT)
Received: by mail-qk1-x72d.google.com with SMTP id af79cd13be357-777252c396bso372791285a.2
        for <linux-kernel@vger.kernel.org>; Tue, 17 Oct 2023 13:20:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dabbelt-com.20230601.gappssmtp.com; s=20230601; t=1697574027; x=1698178827; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:to:from:cc
         :in-reply-to:subject:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=j8cW9ID9EmRaqAP0KD7ZrNU0hcrtypKLPEuHrHMnWGw=;
        b=eaK7WyjXVtuIOu3DNMYTW2H3DM1OO3efBCxr1D2aWWH1lXJ+NoNNKmawlr+Q5HAcB0
         cxKloWC478wPXDpGSE+Tg7XkS1/r2Oy8NVjfkAbrtqB0fD3B+rLvvPFSFF+mSthK3t2Y
         68bvqH22paPO9Wt/2RAbCm5vj1pWWLrdBcVh57cbQbwur3MUVkEjiNJ9UG8+1BueocKl
         xtXruKGmKEYXqwvOVooELG35vyvkpAfIFLeuE8QXFtH2f36bj1DDJFiKmjJq6r0zqAWO
         Qhzl9+qRbgl80IAJRI1Kl+0nP92tHIUuYUSnSdrTk6Cpy0e2HDv0geNvMBzh9ReIthUs
         lwUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697574027; x=1698178827;
        h=content-transfer-encoding:mime-version:message-id:to:from:cc
         :in-reply-to:subject:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=j8cW9ID9EmRaqAP0KD7ZrNU0hcrtypKLPEuHrHMnWGw=;
        b=vmA/0SbcomgPq3x89qB/0ZXxWhhvi5Bb70wSN6EhyzxMwxqceWdtbci1KCaHwnXYMr
         Ap+V6QSCjTfzrLLBrQdgSF5bj7XOkaBImw+pfX+Ha1N7XOnfsg8sL1zosiabHnFR83sI
         oR7RIVKK06EGDdFnKx9dOAluN+/mf2VuHuqLWYH+dHJASJ8YghYnPFzyqrucQAiwEKV5
         1uiBL4mTmS7vCZaUBoKMkMZkhm21oDwLVGN8Aao6xnj2+B7md7bp92YaRzMvNjCNwGYb
         sANQ89DHvL2f0JQMkVZmbHAwYmlr3fXyhAN1cHnjqbSzlsHL5t2qRq4XqaTi34GHAWSu
         DMag==
X-Gm-Message-State: AOJu0Yw3ESIocidReKs9CMyuesyvlYYO4aduG3oWzryXdR9Qhn4V0b5E
        8j7+M4nFxnoMg/4AX7LZtNuc9g==
X-Google-Smtp-Source: AGHT+IGBdwLL1rTJz7m72BA4cEO0GhgKNcA1DZZYX304OW5yBY337OahOIU9yj8GTdS5m16s4rvohA==
X-Received: by 2002:a05:620a:3195:b0:76e:f5c5:1bac with SMTP id bi21-20020a05620a319500b0076ef5c51bacmr3565791qkb.48.1697574027422;
        Tue, 17 Oct 2023 13:20:27 -0700 (PDT)
Received: from localhost ([208.116.208.98])
        by smtp.gmail.com with ESMTPSA id t27-20020a05620a035b00b0076cda7eab11sm918216qkm.133.2023.10.17.13.20.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Oct 2023 13:20:26 -0700 (PDT)
Date:   Tue, 17 Oct 2023 13:20:26 -0700 (PDT)
X-Google-Original-Date: Tue, 17 Oct 2023 13:20:23 PDT (-0700)
Subject:     Re: Covering DT build in -next merge
In-Reply-To: <ZS7rlTZLr0m1OEv8@sirena.org.uk>
CC:     Stephen Rothwell <sfr@canb.auug.org.au>,
        linux-next@vger.kernel.org, linux-kernel@vger.kernel.org,
        soc@kernel.org
From:   Palmer Dabbelt <palmer@dabbelt.com>
To:     broonie@kernel.org, Conor Dooley <conor@kernel.org>
Message-ID: <mhng-9d3c8241-8749-4b5e-bb01-64cf5e2d0bb8@palmer-ri-x1c9a>
Mime-Version: 1.0 (MHng)
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 17 Oct 2023 13:16:21 PDT (-0700), broonie@kernel.org wrote:
> Hi Stephen,
>
> I was wondering if it might be possible to add DTB builds for relevant
> architecutres to the -next merge checks (everything except x86 AFAIK)?
> Some current experience suggested to me that it might be helpful for
> bisecting problems found in testing, breakage building the DTBs causes
> hassle since where they're used in tree DTs are required to boot the
> kernel.
>
> At least for arm and arm64 the DT build is quick enough to be negligable
> in the context of building the kernel itself so hopefully it shouldn't
> add too much load to do this - it's just adding a 'make dtbs' (with
> appropriate cross build options) to the kernel build.

Pretty sure we're in the same shape for RISC-V these days.  +Conor, who 
would know for sure (as he made it work).

>
> Thanks,
> Mark
