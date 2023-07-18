Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1BAD1758774
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jul 2023 23:47:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230198AbjGRVre (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Jul 2023 17:47:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54424 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229953AbjGRVrc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Jul 2023 17:47:32 -0400
Received: from mail-yb1-xb2e.google.com (mail-yb1-xb2e.google.com [IPv6:2607:f8b0:4864:20::b2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BAEBF1996
        for <linux-kernel@vger.kernel.org>; Tue, 18 Jul 2023 14:47:30 -0700 (PDT)
Received: by mail-yb1-xb2e.google.com with SMTP id 3f1490d57ef6-c84fd44593aso6380330276.0
        for <linux-kernel@vger.kernel.org>; Tue, 18 Jul 2023 14:47:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1689716850; x=1692308850;
        h=to:subject:message-id:date:from:reply-to:mime-version:from:to:cc
         :subject:date:message-id:reply-to;
        bh=f+GjSl8O12Td8YnKfGOdIwzIbnxBu6tpmFilTH8epCA=;
        b=BPrNel3FQFhkQ6abu/b3LdzIlzmqWJ5DSx9flmvUq7TmhNFEhqsDNGJJ4CtH47eGnq
         DPpuDNmgXYL5TMjYKkusPAoy6eCZx+W5Qbn5sYvkVv4biLDZESNM/tnjwhuxCy2W1Rnt
         JSO2GRFoCiHgZVAZ8OK5kIRAd9rygMbazTnIlYr4/veNh67y0BLbEPRJA6zB4q+E+hu4
         BlE4MXRhFI22nWEX0dvcRtvUJjs1D5iIGHWBbTyY/+1yz/omgzXoFGu+pUW0yc+YWytR
         rvuOrWQLZPdsSRZcoAySo1mBZ6LxJrdRNVWH7FYzrynnilCAuMsUfjtdcVCk0nTVaZEo
         0nrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689716850; x=1692308850;
        h=to:subject:message-id:date:from:reply-to:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=f+GjSl8O12Td8YnKfGOdIwzIbnxBu6tpmFilTH8epCA=;
        b=NA4qcklmCE/BOJdMmQ3y0CkBFpl6j95bCxFKdzJpsB+EPLhO2QKhppgfBTVqNUPGXU
         bK0X+ljjg+LBvjBa6SJGzuy7pjQGlmyvQqH4Y1+1gFNLgqW982fcKy/DDJTKyRoDnMpl
         FKHHgycnAj3gd840Jrc0av2w+XaGFQ0+jP8QR057ygeiOqdOt/A+HvuzCTFBWGTxKd/n
         e63mllC0ddFLRb/iC2qxZJBmm7KXg8xjOn/2KREPaoBkBtJa7MVb/je4a2GwXhn28BN9
         2lTz2EAkAfbzccV+afBDvU0kqp04NzLJ4a4BbYJx0aBXejLWtCUCuPHTeR9OcHBXLkvt
         opjw==
X-Gm-Message-State: ABy/qLZkCnylJkqUJepFpsn3vQWRvZ1quKaO7IjYNWiHYLnTcsG6ymc3
        IgKTcswBn0Y1FqFImVVHO04ghi8jHfeM4LT29kY=
X-Google-Smtp-Source: APBJJlHT/5fTV4V6n1AwGMlOWtzHdc7H4c1xOFqoSz8ECmXxs4G14XsEEBJZiymmUOkv+gVY1LO7FfCEJFPLRly6FfE=
X-Received: by 2002:a05:6902:342:b0:ced:75b3:6dee with SMTP id
 e2-20020a056902034200b00ced75b36deemr811408ybs.56.1689716849718; Tue, 18 Jul
 2023 14:47:29 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a05:7010:5187:b0:35e:c50b:15cd with HTTP; Tue, 18 Jul 2023
 14:47:29 -0700 (PDT)
Reply-To: Jackkssondavid@gmail.com
From:   David Jackson <wisdomaka881@gmail.com>
Date:   Tue, 18 Jul 2023 21:47:29 +0000
Message-ID: <CADxX=FNamHG8X1bs_kP4t8A41RMeunLPHO3fDQY5-xCKybwj2A@mail.gmail.com>
Subject: 
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=4.5 required=5.0 tests=BAYES_50,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,FREEMAIL_REPLYTO,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,UNDISC_FREEM autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Level: ****
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

I am still waiting for your response regarding my last proposal.

Sincerely,

Jackson David
