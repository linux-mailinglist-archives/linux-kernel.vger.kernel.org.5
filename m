Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 38D457DFD56
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Nov 2023 00:45:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230041AbjKBXpu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Nov 2023 19:45:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38036 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229628AbjKBXpr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Nov 2023 19:45:47 -0400
Received: from mail-lf1-x134.google.com (mail-lf1-x134.google.com [IPv6:2a00:1450:4864:20::134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5FCAB191
        for <linux-kernel@vger.kernel.org>; Thu,  2 Nov 2023 16:45:44 -0700 (PDT)
Received: by mail-lf1-x134.google.com with SMTP id 2adb3069b0e04-507a5edc2ebso706e87.1
        for <linux-kernel@vger.kernel.org>; Thu, 02 Nov 2023 16:45:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1698968742; x=1699573542; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zzVKlaiod0CngpLisgCRPf+f2Cpx/+xdbOa7NmPeDT0=;
        b=vwdQ5Nh8LQNmRryImuVdi64KmuYJvuTlrJPsdqUn5OvwP8XgsO6sKJVMrUbx65P8ca
         VSZgC++sPEq7R2G/QCjSFGtT+qjHp4nwyD+SGFo04LVxlhsOcwF8LiJ442fx+wd8SEdB
         yG9dydLp4AzCmvmkcBHGfwfY2UrwrjBtg9KIvGaZMSlYwtyRVWfJFuQgR+kuhXt9UiZp
         ARfv7M0+0rn6jcgVi0C7S4UHSa0mP1JD4NkyRdKy3QLGcNHWWXxC19h5nJqyZwPiDCPa
         i8vS/Nd5wIDn0as3rOFicAJjztg/5aHkwvB2K9Qf0AfXryV78E9Kgz0z6jjW2aE1HotR
         V1yA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698968742; x=1699573542;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zzVKlaiod0CngpLisgCRPf+f2Cpx/+xdbOa7NmPeDT0=;
        b=WM2SAoDNY9ci43TYfVhtN9pnthRweYX+Hs4Ic2waBYmygCZhuHLNuAU7X6zqAPhKge
         2yYqHJnA1eCdEBhfSRkuwKgs+BuWWV884dfdEHrsspPwR4ty1x42EqnePO/C6a3p9T8X
         mC8WV5h6My7W2D537zBPKPYAWlaGGVn32qFRhmOVj2Pomxlpb2rVKq/Sj17aHtsmXctk
         NvxXKaoEQoo2HGCb+omrxbKx/jBUqVgA/HIsWVD7gmsYcPx/DO+Yd0A2p0TW65KrlBJT
         iBPYHHuhze3TphkkJTfvMQvzXKo8aIt3wgRxYsQtN2N3VocdYqcchpvD7gOLtl4koSxm
         OFSw==
X-Gm-Message-State: AOJu0Yy0hjkjz+BrGjrIpB1HGNwelYvuhk3kumo2KwIecRyInEDqbBFw
        PTSbrUaVONpq9qKatYdsAXi/Uk+l0ux8YiocXSmr7w==
X-Google-Smtp-Source: AGHT+IExGe73wgTrfJdzRkVPgDFGBpgEqEMn1dV8j06kzT4rwg9Y3S46q7dgumgQyjs44vbdPYccDR/eeVAiQIAPDvs=
X-Received: by 2002:a05:6512:70a:b0:509:47b9:d9dd with SMTP id
 b10-20020a056512070a00b0050947b9d9ddmr78141lfs.0.1698968742391; Thu, 02 Nov
 2023 16:45:42 -0700 (PDT)
MIME-Version: 1.0
References: <20231102161117.49533-1-nick.forrington@arm.com>
In-Reply-To: <20231102161117.49533-1-nick.forrington@arm.com>
From:   Ian Rogers <irogers@google.com>
Date:   Thu, 2 Nov 2023 16:45:30 -0700
Message-ID: <CAP-5=fUDMe+UCdL4ZFtQat+xLOEJ96PJAD1E18wG6NuLRpygRw@mail.gmail.com>
Subject: Re: [PATCH] tools/perf: Fix man page formatting for perf lock
To:     Nick Forrington <nick.forrington@arm.com>
Cc:     linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Arnaldo Carvalho de Melo <acme@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 2, 2023 at 9:12=E2=80=AFAM Nick Forrington <nick.forrington@arm=
.com> wrote:
>
> This makes "CONTENTION" a top level section (rather than a subsection of
> "INFO").
>
> Fixes: 79079f21f50a ("perf lock: Add -k and -F options to 'contention' su=
bcommand")
> Signed-off-by: Nick Forrington <nick.forrington@arm.com>

Tested-by: Ian Rogers <irogers@google.com>

Thanks,
Ian

> ---
>  tools/perf/Documentation/perf-lock.txt | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/tools/perf/Documentation/perf-lock.txt b/tools/perf/Document=
ation/perf-lock.txt
> index 503abcba1438..f5938d616d75 100644
> --- a/tools/perf/Documentation/perf-lock.txt
> +++ b/tools/perf/Documentation/perf-lock.txt
> @@ -119,7 +119,7 @@ INFO OPTIONS
>
>
>  CONTENTION OPTIONS
> ---------------
> +------------------
>
>  -k::
>  --key=3D<value>::
> --
> 2.42.0
>
