Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C8B2577658E
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Aug 2023 18:51:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231269AbjHIQvJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Aug 2023 12:51:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57150 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231981AbjHIQu5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Aug 2023 12:50:57 -0400
Received: from mail-oi1-x230.google.com (mail-oi1-x230.google.com [IPv6:2607:f8b0:4864:20::230])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EAA713A81
        for <linux-kernel@vger.kernel.org>; Wed,  9 Aug 2023 09:50:20 -0700 (PDT)
Received: by mail-oi1-x230.google.com with SMTP id 5614622812f47-3a3df1ee4a3so4155906b6e.3
        for <linux-kernel@vger.kernel.org>; Wed, 09 Aug 2023 09:50:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1691599811; x=1692204611;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=He4IvUcYyIKK2RGPWRy7aXvjheVu5viAkGNtt/+Ke8E=;
        b=xBTpEF3zpYUq+bjikeX7zSzA/ywa4MrIaUSU74cTEQVvb2kfDdc2Ur+agpsIOxiWnj
         vchYSEhe6u1Fuz6izzgZMbW99gKgXEwyq5FyeO81G5FstwNSDtsIlRr0cW8u53yTCYwj
         gDDBlqWllJddw+qUmhbo06Ia6R3LJDrTZ2hJiWt7recqMyTPuyrgxExNLV4ZosVQS0M+
         wLTdbz7Qt3XFpRXR2d+vg/tuU6O6K7koKTaManMKKYaQS0uSfohiaHAhrzG95P+n3bQv
         9hBg5FJCA6VmKfBIRWtr8p1CEDhtmlGIbquKvfs1gGzha1NJ2oRv0fU4CxrHFE1r0nal
         VzeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691599811; x=1692204611;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=He4IvUcYyIKK2RGPWRy7aXvjheVu5viAkGNtt/+Ke8E=;
        b=KU5vD0GSKGdcrga3H3tEzrhVY0Hjxe7viEs9c7q58ZHbUIj1kSA/5whFmIsyt9kF/1
         9d3ST6evRD5h5PARJSpm1WH51TsJS9ix2alzrFAp5ZnxL+cWPVYt86lZX0R6MtH2ALfu
         INVkGTwhvioY5PgUiWDpPf81bbteWeCSyBmEkMmey75fqzA54jgP27saBjKt+IzBdhYt
         Q1O+dn1PIzGzPaRNDiQrmT/K0G6Z6tyjkSg4+zLMzWz74vZgYgI6AovebklLnHh1Q+fz
         cdjLui4yyk7+keDL8XOXiofZWnUreofS1oqB1w9bBb1WNBrxwUqcNbTgLa8ebYQu/kL5
         7wgQ==
X-Gm-Message-State: AOJu0YzgCf53iTXukMWF59thLp31Wqf9EmFHeUoTenje6wyn2/PHFpx8
        wiR8Tmas4s9L5IVwhCtMm9gDXkIdpO/GYpfTlCLpBA==
X-Google-Smtp-Source: AGHT+IH3CHHnMNfpdOqa4g0/dtp+71gOteaQ08Cs0j+UAFIHskfWfZjHpskTSdvYCFsDCMkWf9ptsh2Hp7Wba1RmRpg=
X-Received: by 2002:a05:6808:3a97:b0:3a7:7bea:d3cc with SMTP id
 fb23-20020a0568083a9700b003a77bead3ccmr3417956oib.0.1691599811381; Wed, 09
 Aug 2023 09:50:11 -0700 (PDT)
MIME-Version: 1.0
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Wed, 9 Aug 2023 09:50:00 -0700
Message-ID: <CAKwvOdmOVnhKws_6DdakK9SDxiCCCR1d6VJwvz94Ng_y3V8QCg@mail.gmail.com>
Subject: get_maintainer, b4, and CC: stable
To:     Joe Perches <joe@perches.com>
Cc:     Konstantin Ryabitsev <konstantin@linuxfoundation.org>,
        "Kernel.org Tools" <tools@linux.kernel.org>,
        "# 3.4.x" <stable@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Joe,
A recent mistake I made when using b4 was that I added a fixes tag,
but forgot to Cc: stable in the commit message.

Speaking with Konstantine, it seems that b4 may just be importing the
recommendations from get_maintainer.pl.

I suspect that either b4 or get_maintainer could see the Fixes tag and
then suggest to Cc stable for me.

Should get_maintainer.pl make such recommendations?
-- 
Thanks,
~Nick Desaulniers
