Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B27547CA686
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Oct 2023 13:18:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232447AbjJPLSW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Oct 2023 07:18:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39128 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231340AbjJPLSU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Oct 2023 07:18:20 -0400
Received: from mail-ej1-x630.google.com (mail-ej1-x630.google.com [IPv6:2a00:1450:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A1A483;
        Mon, 16 Oct 2023 04:18:18 -0700 (PDT)
Received: by mail-ej1-x630.google.com with SMTP id a640c23a62f3a-9b2f73e3af3so669923966b.3;
        Mon, 16 Oct 2023 04:18:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1697455097; x=1698059897; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=iZ3MOd8AfPXRutQJtnyGXQRK73tC6YBnYLnrIxJBVGo=;
        b=SIbae3nIe3w1MccVfT37vcctdL68itDb/Aq9azQ6920Pdmq/vz8lK/gMQ4zdbS6NKf
         r6VNgY2VzMYlHTuCIsMW/RGSnGRpDGU8SweNdBzEDGwUG+cyiS7l8348AEjg7kMutLdx
         j/5cAofvDOdV0bbyQ3alVB7EXIsJeIxKnZcLFk6knoiYhjsvg9C5fhLJgMnSH0LiOtCB
         NxQBKXAyN94z/lwQCelcTZzcvsX7c9s9na4oHQ4x12p0kadWoHG/KKKpzCH3n0+yB1R7
         AFOIG5SAeWyBk9lvnTL8yX8WyY1NVQ4Y3yIG6p4YAy1xNkhT0vvvGmOI3+mB5NRdc0vf
         SQjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697455097; x=1698059897;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=iZ3MOd8AfPXRutQJtnyGXQRK73tC6YBnYLnrIxJBVGo=;
        b=QicPvDQLqjx2FilsDXaT5yxR8ZturRYpvGiQcASxRLxLQ3htHnIBDjCwVu791O2BY/
         9Qz4t8ibOvU7y14iWmcjtkJ5v0U5h8tMb3mMEtV2c4Vkl2a3RVMMaaCM3Sn6lEiIgNfg
         bVY/x3s1SpVO6Pchk/APCIRKIdcW4a4B6MKio/rrtBz/EZZwwhCTIe809X1MlueZYprG
         QOMIjx42A804RVm/+g8BOreTNEo8j+B7+aoc7okz8ZX6M9W4TNjc/R2wOKZ9QvDR/4bO
         S5ojmfXNxMw8pCF/XEFErfiHirLVgNpYf9PAvV7hu45IrxjEkLRDcpJOSWcOak80h+7A
         7WXA==
X-Gm-Message-State: AOJu0YwPeL6SarUIAF7f44tpcruU6+kF+TRcr3+6SuWK8Oy7HzOy/BJ0
        KLWDA1feSo61RPlqspdpN+I=
X-Google-Smtp-Source: AGHT+IHctV7CbNl5MzddeR1WSsnu6gsJRhRP5ulhdx9tNwTzWvroiApj3re5aYj3fINMGxZL7uqbEw==
X-Received: by 2002:a17:907:3d93:b0:9bf:7e40:17b2 with SMTP id he19-20020a1709073d9300b009bf7e4017b2mr4811857ejc.59.1697455096840;
        Mon, 16 Oct 2023 04:18:16 -0700 (PDT)
Received: from gmail.com (1F2EF7B2.nat.pool.telekom.hu. [31.46.247.178])
        by smtp.gmail.com with ESMTPSA id c16-20020a17090620d000b009ae587ce128sm3795766ejc.216.2023.10.16.04.18.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Oct 2023 04:18:16 -0700 (PDT)
Sender: Ingo Molnar <mingo.kernel.org@gmail.com>
Date:   Mon, 16 Oct 2023 13:18:13 +0200
From:   Ingo Molnar <mingo@kernel.org>
To:     Dan Carpenter <dan.carpenter@linaro.org>
Cc:     Uros Bizjak <ubizjak@gmail.com>,
        Sandipan Das <sandipan.das@amd.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Ian Rogers <irogers@google.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
        "H. Peter Anvin" <hpa@zytor.com>, linux-perf-users@vger.kernel.org,
        linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org
Subject: Re: [PATCH] perf/x86/amd/uncore: fix error codes in amd_uncore_init()
Message-ID: <ZS0b9R9ufXQmohOh@gmail.com>
References: <cec62eba-c4b8-4cb7-9671-58894dd4b974@moroto.mountain>
 <ZSjyJuqk3z0RyKP2@gmail.com>
 <0c973a20-e10c-4989-b7d9-86cb0f522718@kadam.mountain>
 <ZSkInflBriOL9V3M@gmail.com>
 <CAFULd4b7F=MNMduRn99FFcAc7Of7RsL+vyXVzsiBZZ9hz0+HnA@mail.gmail.com>
 <ZSpZRM4ZEnNy98Rz@gmail.com>
 <f13b0b1a-e5f8-48db-9a09-1ef88cc6c6eb@kadam.mountain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f13b0b1a-e5f8-48db-9a09-1ef88cc6c6eb@kadam.mountain>
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


* Dan Carpenter <dan.carpenter@linaro.org> wrote:

> The surprising thing is the Clang doesn't detect the bug either.  It's
> strange.  (I found this bug with Smatch).

Yeah, that's weird and kind of concerning. I don't think either compiler is 
able to see that the init function return values are always ignored. I had 
to dig into init/main.c to convince myself.

> Also I notice that my Fixes tag wasn't correct either.  That patch did 
> have a missing error code bug, but "ret" was set to zero.  :/

Yeah, so I left the Fixes tag out of the commit anyway, because this isn't 
really a fix that -stable should concern itself with. After the first 
commit it's not even a fix per se, but an improvement in the resolution & 
meaning of error codes or so.

Thanks,

	Ingo
