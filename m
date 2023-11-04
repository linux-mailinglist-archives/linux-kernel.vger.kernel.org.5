Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5BA7C7E0CFE
	for <lists+linux-kernel@lfdr.de>; Sat,  4 Nov 2023 02:09:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231618AbjKDBIW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Nov 2023 21:08:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47942 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229557AbjKDBIV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Nov 2023 21:08:21 -0400
Received: from mail-pf1-f182.google.com (mail-pf1-f182.google.com [209.85.210.182])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 68CCBD61
        for <linux-kernel@vger.kernel.org>; Fri,  3 Nov 2023 18:08:18 -0700 (PDT)
Received: by mail-pf1-f182.google.com with SMTP id d2e1a72fcca58-6ba54c3ed97so2782788b3a.2
        for <linux-kernel@vger.kernel.org>; Fri, 03 Nov 2023 18:08:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699060098; x=1699664898;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=I/Y27XOKFlrNGzh4/FEG0aIQx/21ZYDrmaDfwYWuf7M=;
        b=XLAP6dQ9evMeXCCuK+CtCMV8QaEWxtSFMcCxmRU4GvOsuROX8l395994j6wW/OHWNC
         wSog7wn7G4X3snNGxkZqOhqd7Asr9X2THryA/AmCUTdY9yMWkqXiBBbUvy6IM4XkQTB9
         LuAjSJr6gASzKb872zpRLEcDqQTMxe1MuR1BTtq4gazMp/+eIA8rkc87awxlpUkQghQY
         rk7HJVKSGnxhCFDaO5NnxAqlaPQWsEn6HDVuh2khVgbeOm1k+VPjEF4sITprZ6qkilWB
         8f/0jdzr0E628huwbVOxFhAb7TjSXMYnUzr0MAUlsFTxSV6L1stAtaxdwrRRIlOQnAsp
         OBHw==
X-Gm-Message-State: AOJu0YwAVKUK6dFmOxKHSbnV/Hh55/yRJW6PEBBeNIMDqNZ6AX2qB7Q1
        HPm+r62JPW1G3HgPmsuiGk0bO8U36kTlM6Cf5pI=
X-Google-Smtp-Source: AGHT+IENv2ugQ4SJf9eV147PuqiYIjycWu87B92lyMszSnstgO7l8D2sdMxUnTK16ybp8g0nv919hSSf8jLNFUu18A0=
X-Received: by 2002:a05:6a21:66c4:b0:180:23d2:b5e5 with SMTP id
 ze4-20020a056a2166c400b0018023d2b5e5mr24160448pzb.60.1699060097667; Fri, 03
 Nov 2023 18:08:17 -0700 (PDT)
MIME-Version: 1.0
References: <20231102150919.719936610@infradead.org> <20231102152018.499897182@infradead.org>
In-Reply-To: <20231102152018.499897182@infradead.org>
From:   Namhyung Kim <namhyung@kernel.org>
Date:   Fri, 3 Nov 2023 18:08:06 -0700
Message-ID: <CAM9d7cg9N9izyKu1D4u0g_pfjLWaeR8rucbRKMx23kj8gs7x4A@mail.gmail.com>
Subject: Re: [PATCH 07/13] perf: Simplify: __perf_install_in_context()
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     mingo@kernel.org, linux-kernel@vger.kernel.org, acme@kernel.org,
        mark.rutland@arm.com, alexander.shishkin@linux.intel.com,
        jolsa@kernel.org, irogers@google.com, adrian.hunter@intel.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

You may want to remove ":" after Simplify in the subject line
here and the next patch.

Thanks,
Namhyung
