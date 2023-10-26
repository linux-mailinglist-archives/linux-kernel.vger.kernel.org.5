Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7320D7D8753
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Oct 2023 19:11:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345403AbjJZRLZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 Oct 2023 13:11:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32968 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235016AbjJZRLW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Oct 2023 13:11:22 -0400
Received: from mail-pf1-x433.google.com (mail-pf1-x433.google.com [IPv6:2607:f8b0:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7B3691AA
        for <linux-kernel@vger.kernel.org>; Thu, 26 Oct 2023 10:11:20 -0700 (PDT)
Received: by mail-pf1-x433.google.com with SMTP id d2e1a72fcca58-6b709048f32so1107499b3a.0
        for <linux-kernel@vger.kernel.org>; Thu, 26 Oct 2023 10:11:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1698340280; x=1698945080; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/r7bdbQh86tW1vE5bFuVkr1iUVfoyyl7YZtQbBNpAm4=;
        b=XtJ7ULjmGA0HGhJ4GFm/oVhn9DfonlSVR6WO+ay8xoT0jGNYntK2xdWM16Sy/vQtEP
         /EB7dj0xprC17r1fUBUBCamrnm6lKNxQfCvA+Bo1+5dyx54NPCJUSdgyjkbfIovC7Z35
         b6BThfsXFgWRjyut5Frj6YW1Ejmjy8vPeyJ+Os2U/AOD8qYVSFVkasTAV4tCi17lmOOF
         1z/W9hfa3YwLf9Rrfs51gb9H6uWbPZzSgWIH1HCGapgh0avPUon+bNaozyyBjBS7nvoS
         5XHLzbXy73MewhWu+zImZHK1ijWEvh6MDH6tpQim0M6dCn64jt9qGAsP+1PGukzhNTmB
         x6Ig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698340280; x=1698945080;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=/r7bdbQh86tW1vE5bFuVkr1iUVfoyyl7YZtQbBNpAm4=;
        b=E6ozM88hOpod9OBO3Sh07pGPpxhXB5WOdECmqDo7ToHpPWScME7XdAGEOVqiNnB1E/
         vmBRE+OQr/RaV0bIFig9CWdSkPhy/xWodEda0H9J7IJVRhCIptwtNMk7azcs138S2i9I
         MTH1rPKAx6K3HLCmEsFolX+jD9yub7bfQKk6zyIPGhQvwvhlXzivVWQibDJaFVsW7G8X
         yO/IOYLiUkQRbHkWX/0YV4MZZd5lBn13VF5bcYcvMiqowZ+F+BaSQU1bk1uxVSe4FQBN
         mKi758nVsdrhmPgk/y9cbP63c7sw6CoxSCgbTgST1bS4gh5uGggAMIExAsNpvU1ckyPh
         xYnw==
X-Gm-Message-State: AOJu0YzbNTedXnVAMXZfgfDCnvbH1TjYX97Fru9VTbpIaIqRmDj/KTXE
        NOqBPEH3KMw93pSLlBAGiL1FHbD5ZpA=
X-Google-Smtp-Source: AGHT+IETkQRdplPrGPVEyvCAMYnCNn4ReWubh9PRR2e/P9Qnl55fdOEAspSNE1vc9kRMLrcZXsRcxA==
X-Received: by 2002:a05:6a00:391c:b0:6b7:cc4b:21d8 with SMTP id fh28-20020a056a00391c00b006b7cc4b21d8mr152429pfb.1.1698340279772;
        Thu, 26 Oct 2023 10:11:19 -0700 (PDT)
Received: from moohyul.svl.corp.google.com ([2620:15c:2a3:200:ec51:cb82:a169:2ada])
        by smtp.gmail.com with ESMTPSA id k15-20020aa7998f000000b00688965c5227sm11356315pfh.120.2023.10.26.10.11.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Oct 2023 10:11:19 -0700 (PDT)
Sender: Namhyung Kim <namhyung@gmail.com>
From:   Namhyung Kim <namhyung@kernel.org>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Ian Rogers <irogers@google.com>, Jiri Olsa <jolsa@kernel.org>
Subject: Re: [PATCH 1/1] perf build: Address stray '\' before # that is warned about since grep 3.8
Date:   Thu, 26 Oct 2023 10:11:08 -0700
Message-ID: <169833996388.1181734.15291394759037663241.b4-ty@kernel.org>
X-Mailer: git-send-email 2.42.0.758.gaed0368e0e-goog
In-Reply-To: <ZTj6mfM9UqY2DggC@kernel.org>
References: <ZTj6mfM9UqY2DggC@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 25 Oct 2023 08:23:05 -0300, Arnaldo Carvalho de Melo wrote:
> To address this grep 3.8 warning:
> 
>   grep: warning: stray \ before #
> 
> We needed to remove the '' around the grep expression and keep the \
> before # so that it is escaped by the $(shell grep ...) and thus doesn't
> get to grep.
> 
> [...]

Applied to perf-tools-next, thanks!

