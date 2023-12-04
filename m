Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 099C2803E13
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Dec 2023 20:07:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232408AbjLDTHm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Dec 2023 14:07:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35964 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231266AbjLDTHk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Dec 2023 14:07:40 -0500
Received: from mail-lf1-x12f.google.com (mail-lf1-x12f.google.com [IPv6:2a00:1450:4864:20::12f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EB9BBD5
        for <linux-kernel@vger.kernel.org>; Mon,  4 Dec 2023 11:07:46 -0800 (PST)
Received: by mail-lf1-x12f.google.com with SMTP id 2adb3069b0e04-50bed6c1716so363e87.0
        for <linux-kernel@vger.kernel.org>; Mon, 04 Dec 2023 11:07:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1701716865; x=1702321665; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=L5vT+APsCg/FSnZpn7O3Zjrf90SobvyinAQOiMG7ovE=;
        b=BEK5wg55zv/26SDQVThLidaR3OyBNLeewBTEyZRSvwL6nGdtFeKH1R4X1HAXhBU7y7
         KMV1FmUcLPPygZlFgHcOHdFwH/i86PvQlFIc0q4cXv57pC+5eJmbv3RmYPgvsHvPDMj0
         rRBFf4yOKIuUCB8L6ym44bnYuv8D3hMpekRSd1Y8lQRICQyqk1CTwoqL+ZIRrqWZ5FiT
         qDsNdFkBts+7pHbm+AjYMSdcIX2ER2nGe+Mom32/I03hJCe02LteZ0/4mh7l7nX9r5tI
         M5PWxKhjf6z3TGtpfe9ymtfeRhmdUecEETeKcw5u4SQM65llCCzHRtxH1qtc7rbRYEAv
         pEFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701716865; x=1702321665;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=L5vT+APsCg/FSnZpn7O3Zjrf90SobvyinAQOiMG7ovE=;
        b=l8M7/Ugbzrtx+kZL5i6jyunnLQsiKBxQP+QNEGeSEYdPOzMTOk1ziXDiThibKdTUNC
         2Wp7lxqIdTjEl4KzM2VWz9f40u6bGABqKSZa9XxplhdT4i5sAAwCv74RIaBeo1d4UKW4
         SyHxvcUNcQIJkRzf8TDNq1kVrZ1faBrSOewyo1Z7lIBUc2HQUTHfaLGS8PQsQ2n/YTDR
         7O/iQKHAcmnyXixhFtzvCkCnELwhnjUtT9IXDEHL377tojxS9GRmWAFb2B83XOlY0pVd
         U4fSmQnMgVzABy25xkOVPSyfMM1MYjCcnzimu82FfUGtSzRA5MGj2MeTN5DTYbZw+VGP
         YjPQ==
X-Gm-Message-State: AOJu0Yx3R7ltdB+MC2NMpR5q28IQZm5puJiNkg8pm5Z3EBqqQQGIGgrO
        Qvt3DEU2MamG81h4Hp9TywDuhR6+b6djEdEg9qrsTA==
X-Google-Smtp-Source: AGHT+IHA5w0Z03xioU+ynWPCd+l8I8tcc2/QWPNYlKSj00tvSmrlzBmx02FNAGzxpNIvbZ4Sr/LO/nzLLiUbp3mEG1A=
X-Received: by 2002:a05:6512:1153:b0:504:7b50:ec9a with SMTP id
 m19-20020a056512115300b005047b50ec9amr324664lfg.1.1701716864963; Mon, 04 Dec
 2023 11:07:44 -0800 (PST)
MIME-Version: 1.0
References: <20231201021550.1109196-1-ilkka@os.amperecomputing.com> <20231201021550.1109196-4-ilkka@os.amperecomputing.com>
In-Reply-To: <20231201021550.1109196-4-ilkka@os.amperecomputing.com>
From:   Ian Rogers <irogers@google.com>
Date:   Mon, 4 Dec 2023 11:07:33 -0800
Message-ID: <CAP-5=fUEsLQ+kqh4eo_5mcrEe_tHJ=t4CAxd7Um7aD8T+t4yTw@mail.gmail.com>
Subject: Re: [PATCH 3/3] perf vendor events arm64: AmpereOneX: Add core PMU
 events and metrics
To:     Ilkka Koskinen <ilkka@os.amperecomputing.com>
Cc:     John Garry <john.g.garry@oracle.com>,
        Will Deacon <will@kernel.org>,
        James Clark <james.clark@arm.com>,
        Mike Leach <mike.leach@linaro.org>,
        Leo Yan <leo.yan@linaro.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-perf-users@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 30, 2023 at 6:16=E2=80=AFPM Ilkka Koskinen
<ilkka@os.amperecomputing.com> wrote:
>
> Add JSON files for AmpereOneX core PMU events and metrics.
>
> Signed-off-by: Ilkka Koskinen <ilkka@os.amperecomputing.com>

Reviewed-by: Ian Rogers <irogers@google.com>

Thanks,
Ian
