Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5B6CF76C9DE
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Aug 2023 11:52:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232366AbjHBJwf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Aug 2023 05:52:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54774 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229445AbjHBJwd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Aug 2023 05:52:33 -0400
Received: from mail-pj1-x1041.google.com (mail-pj1-x1041.google.com [IPv6:2607:f8b0:4864:20::1041])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F2033E5C
        for <linux-kernel@vger.kernel.org>; Wed,  2 Aug 2023 02:52:32 -0700 (PDT)
Received: by mail-pj1-x1041.google.com with SMTP id 98e67ed59e1d1-26824c32cfbso518529a91.1
        for <linux-kernel@vger.kernel.org>; Wed, 02 Aug 2023 02:52:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1690969952; x=1691574752;
        h=content-transfer-encoding:to:subject:message-id:date:from:reply-to
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=jcJ7ZszM43yUw4Dip8uMPI2izR3Ue5nkDqphNcmOwkA=;
        b=Wle1GXslK+Li3OtPLPCKAFzWenIr+f0jURZUiRPMBNQhI1aqq2WflXflrlL5uslAMi
         gsQnIN+H0rESbB4qyUs89bO5/xZF1/kAXbAJImAgupl/Kep7ZiI8J3i+TaYfjyzNze5F
         sCDNTLv333FhkfxDv6MN1NmT+UMsrJCczahK2b/MVYYZxDFYuGlMPh+9D1qzRAlurZ40
         IbvPs/oW/TlF7en+r7GO4YWhAg9uoQDyz7ivYyMtgdSiBDC23hqRXAZzC1C2CMxCtlkv
         o7iWiw4vtHQ+1iVJZLTVrsf3xdg6u8n6TClAfOo/oKsqhQPwhY/KDD5XcwtQ8MuUre6v
         JSRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690969952; x=1691574752;
        h=content-transfer-encoding:to:subject:message-id:date:from:reply-to
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=jcJ7ZszM43yUw4Dip8uMPI2izR3Ue5nkDqphNcmOwkA=;
        b=VMfqBp0Zk1UjKzhJQiZV55iYKI10+J2LDQQVfpCdLRitHjOtXkxt2y9sMyZ4iyitJe
         5y7QI3Fw6EHGJqYedt3EdJtXzsgmxPUoSFfxdEGfTvwZSSMxMQLde8LiJM8ibjN+M1yk
         lRTFyxRThPVHi/9e6Wcl3IOJjpgM4J8vM1H6fL/vv79hoDt5vptZPL94iuqzbqcOIpIo
         HYpn6z7UBtp/sd0/uA5LSoHUgGxAhLt5358o2ZyujTVCdxr8gvjrL5pM7s5Y+x/LWStF
         vhLLSiSDXEKmt+/dNOZfaCAgreVRKwMUTMMnGZtU6WIzqMyuno/+pSQgSRY3jy9xq518
         c4iw==
X-Gm-Message-State: ABy/qLboeyFKtu/CPREVhTTGZfjoxN60isM+RWT6+klkUwiAEsXQ9Hga
        aoWaRavgZQ2CnnXdM6iW2Pmga7qRtje83kZIxPM=
X-Google-Smtp-Source: APBJJlEPiIqGrUmDSAla+fkKYV91UPLYCtPrEXuplJmWm9/okFlZAcz8mWdZxvky4V4sjTnCNKgzkDSAB4eRHW0yzDA=
X-Received: by 2002:a17:90a:e657:b0:260:a8da:536c with SMTP id
 ep23-20020a17090ae65700b00260a8da536cmr19135192pjb.23.1690969952408; Wed, 02
 Aug 2023 02:52:32 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a05:7300:478e:b0:e1:f0c8:ce62 with HTTP; Wed, 2 Aug 2023
 02:52:31 -0700 (PDT)
Reply-To: bernardarnault2011@gmail.com
From:   Bernard Arnault <nathanajdcameron66@gmail.com>
Date:   Wed, 2 Aug 2023 10:52:31 +0100
Message-ID: <CACAY2T46=EhZ6f41NVberFop2kuCVSeHdsgcxTqRhQJhS+ecnA@mail.gmail.com>
Subject: =?UTF-8?B?0JjQvNCw0YLQtSDQsdC70LDQs9C+0YLQstC+0YDQuNGC0LXQu9C90L4g0LTQsNGA0LXQvQ==?=
        =?UTF-8?B?0LjQtQ==?=
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: base64
X-Spam-Status: No, score=4.7 required=5.0 tests=BAYES_50,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,FREEMAIL_REPLYTO,FREEMAIL_REPLYTO_END_DIGIT,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        UNDISC_FREEM autolearn=no autolearn_force=no version=3.4.6
X-Spam-Level: ****
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

LS0gDQrQlNC+0LHRitGAINC00LXQvQ0KDQrQktCw0YjQuNGP0YIg0LjQvNC10LnQuyDQsNC00YDQ
tdGBINC1INC40LfQsdGA0LDQvSDQvdCwINGB0LvRg9GH0LDQtdC9INC/0YDQuNC90YbQuNC/INC3
0LAg0LHQu9Cw0LPQvtGC0LLQvtGA0LjRgtC10LvQvdC+DQrQtNCw0YDQtdC90LjQtSDQvtGCIDEg
NzAwIDAwMCDQtdCy0YDQvi4g0J/QvtC70YPRh9C40YXRgtC1INC70Lgg0L/RgNC10LTQuNGI0L3Q
vtGC0L4g0LzQuCDRgdGK0L7QsdGJ0LXQvdC40LUsINC60L7QtdGC0L4NCtCy0Lgg0LjQt9C/0YDQ
sNGC0LjRhT8g0JzQvtC70Y8sINC+0YLQs9C+0LLQvtGA0LXRgtC1INGB0L/QtdGI0L3QviDQt9Cw
INC/0L7QstC10YfQtSDQuNC90YTQvtGA0LzQsNGG0LjRjyDQvtGC0L3QvtGB0L3Qvg0K0LjQt9C/
0LvQsNGJ0LDQvdC10YLQviDQvdCwINCy0LDRiNC40YLQtSDQtNCw0YDQuNGC0LXQu9GB0LrQuCDR
gdGA0LXQtNGB0YLQstCwLiDQvNC+0LvRjywg0LjQt9C/0YDQsNGC0LXRgtC1INC40LzQtdC50Ls6
DQpiZXJuYXJkYXJuYXVsdDIwMTFAZ21haWwuY29tDQoNCtC90LAg0JLQsNGI0LUg0YDQsNC30L/Q
vtC70L7QttC10L3QuNC1DQpMVk1IIE1vw6t0IEhlbm5lc3N5IOKAkyBMb3VpcyBWdWl0dG9uIFNF
DQrQky3QvSDQkdC10YDQvdCw0YAg0JDRgNC90L4uDQo=
