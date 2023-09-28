Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C73917B1156
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Sep 2023 05:53:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230105AbjI1DxG convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Wed, 27 Sep 2023 23:53:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34658 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229445AbjI1DxE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Sep 2023 23:53:04 -0400
Received: from mail-io1-f44.google.com (mail-io1-f44.google.com [209.85.166.44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C360EBF;
        Wed, 27 Sep 2023 20:53:01 -0700 (PDT)
Received: by mail-io1-f44.google.com with SMTP id ca18e2360f4ac-79f82b26abfso433092339f.1;
        Wed, 27 Sep 2023 20:53:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695873181; x=1696477981;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xvXKDHU8dCgQlyr4ZtKhvdlZrarpGOogxwwhdFc0rsA=;
        b=sMJYqP0sQCi2t3L/i6aR5nNyw1+VWiPFUN5njQLiXD7lzsIYOx5vFyNChRYyauueRN
         NDw5zFQXlkzg3tPI68EAW7AJmw4DiBrAqYPVyE3koiiqrGdOOqilyVuDsv/2Bo33IGQA
         jeTDNzUdHI26B2y5RzMu92iW6DDOZLRfmzeOVEUWvxQ5UG8pswx4PJRq4r/HGEco3N9i
         /GqiTIsc/tzgDQaw3SFuFu+j8pFiK9shbLCXInp573j3h8bAFt4frXJR+tag9b7tge5n
         VmbrwZo16LuoNWysK3QCB2mHd8JJFnY8U3+i+luAMMlNl3qQDZJtgqkdubyGDbm+suXw
         HL6w==
X-Gm-Message-State: AOJu0YzJuqZoh/ynpJNJ6NsBsx+ZOhPVlXLIrtF0zBBIjyluVdPCv0pd
        gl1uorsDXn5wv010CDrUUYL6OhzCjQzKe+IV3jU=
X-Google-Smtp-Source: AGHT+IHm/6FbTRZxUekuz1SoZ9JXtxWU427MpHMHLiPLHvV2T/i2EQyHvDFH7Jma8+vt3/KH+az9tJ1hBVikMUuS+UI=
X-Received: by 2002:a6b:a12:0:b0:792:792e:6619 with SMTP id
 z18-20020a6b0a12000000b00792792e6619mr107225ioi.2.1695873180930; Wed, 27 Sep
 2023 20:53:00 -0700 (PDT)
MIME-Version: 1.0
References: <20230925055037.18089-1-colin.i.king@gmail.com> <CAP-5=fUht_JQKW8ekDCpHyRbdVe168nmLGrWU21aZDYSyDeMQQ@mail.gmail.com>
In-Reply-To: <CAP-5=fUht_JQKW8ekDCpHyRbdVe168nmLGrWU21aZDYSyDeMQQ@mail.gmail.com>
From:   Namhyung Kim <namhyung@kernel.org>
Date:   Wed, 27 Sep 2023 20:52:49 -0700
Message-ID: <CAM9d7cg59xYzHt-tMQ3C8hohn4710rxAhpAu1c88pb=MJu1tXw@mail.gmail.com>
Subject: Re: [PATCH][next] perf kwork: Fix spelling mistake "Captuer" -> "Capture"
To:     Ian Rogers <irogers@google.com>
Cc:     Colin Ian King <colin.i.king@gmail.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        linux-perf-users@vger.kernel.org, kernel-janitors@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 25, 2023 at 9:08 AM Ian Rogers <irogers@google.com> wrote:
>
> On Sun, Sep 24, 2023 at 10:50 PM Colin Ian King <colin.i.king@gmail.com> wrote:
> >
> > There is a spelling mistake in a pr_debug message. Fix it.
> > (I didn't see this one in the first spell check scan I ran).
> >
> > Signed-off-by: Colin Ian King <colin.i.king@gmail.com>
>
> Reviewed-by: Ian Rogers <irogers@google.com>

Applied to perf-tools-next, thanks!
