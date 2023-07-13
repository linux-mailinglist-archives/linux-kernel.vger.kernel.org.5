Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2B0187515BC
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jul 2023 03:20:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232935AbjGMBUb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Jul 2023 21:20:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56726 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229755AbjGMBU3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Jul 2023 21:20:29 -0400
Received: from mail-qt1-x82a.google.com (mail-qt1-x82a.google.com [IPv6:2607:f8b0:4864:20::82a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F3DEB1BF6
        for <linux-kernel@vger.kernel.org>; Wed, 12 Jul 2023 18:20:24 -0700 (PDT)
Received: by mail-qt1-x82a.google.com with SMTP id d75a77b69052e-40371070eb7so88381cf.1
        for <linux-kernel@vger.kernel.org>; Wed, 12 Jul 2023 18:20:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1689211224; x=1691803224;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WL6clHOfL7C2hzwuxd/sFxhXrd/t/IxXL0MpWSGPbkM=;
        b=iw5fAj3Vfq5oS9pv4JCar5T5vJFnpy44wK+oarIAu11flncOHggNv9BcKTRj5bp2s0
         zoVE4t39cS5rlq69rAos2Iq7IofayAdUzjbeQUxePkt2mVOm9C3oQm8WR/I2+7NfHvn5
         VY4o6j8jR8m7kEqHFpTS44IO5GRpi1lIuA6kUcQgdb/MeNfzlnJ+IwcI0+Fs9JqAVwIc
         pBogtsQLIceeSRNbsT8N9JC8KLb5nEfK8eS6Oi8UJRjo9u3LtvATbLfsXRnD/eT1Yx5p
         iZicS3cwn3ILyx9/X6mtX3BxxDjrQ0NvUlHV1IO+eDMHbVS2R6h8FOdZRqWptbz54Vhu
         qSvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689211224; x=1691803224;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=WL6clHOfL7C2hzwuxd/sFxhXrd/t/IxXL0MpWSGPbkM=;
        b=MLHrV3ONuSDXMgd0Sj+w+hn1amXNe8DgZnPgsthNStj7uVNVZtSoXP7mkW24TpX6OV
         2X9DrrZ5fZl/WBQx1dVjYZHNhwUOpdmwjpxNKvvyOJjLWeDxYJzshZRjxgOopj18XuvU
         9i07x5khhifQKGTHlXKbxIMJBt5RajI5poIV5ZtAK+jH/we2gQ6Fcu19SApXXOvajXLS
         c82dk4NYWd9BiwQ/9CKKty5G+zdx85ooKVASRaNMZ+0AA85jSZ7zqzgrGQECOw7vklau
         znzL8QdyO82dufvH9BdGYWqhIEfituaCCsFZxYeeR3b5R4G8KibFbta3kvjNLwuPhki8
         PfyQ==
X-Gm-Message-State: ABy/qLbgib3drjznKv9IG3kFlRBH+mkzRstX/uZxNq+QWDXLxR2IEdbA
        ThAXyLMFv5EGLdeLzGNcaZwYkYBnJghKcFb67r5txQ==
X-Google-Smtp-Source: APBJJlEVum1x2dgOQB1waY93tVBEFBDp4ECMJSRVJJUfUINAwf4YAgZO5ej/8T8oAgCdzO+R4oMzSYmAivoB9jeH31M=
X-Received: by 2002:a05:622a:1826:b0:403:a6e5:9cdf with SMTP id
 t38-20020a05622a182600b00403a6e59cdfmr449075qtc.8.1689211224028; Wed, 12 Jul
 2023 18:20:24 -0700 (PDT)
MIME-Version: 1.0
References: <20230614062234.24149-1-luojianhong@cdjrlc.com> <329a5b1b6e2c9061467ed6ef82247b8d@208suo.com>
In-Reply-To: <329a5b1b6e2c9061467ed6ef82247b8d@208suo.com>
From:   Ian Rogers <irogers@google.com>
Date:   Wed, 12 Jul 2023 18:20:12 -0700
Message-ID: <CAP-5=fW_tgXjWpevy+y4gY5XxpYq27zHahPZ8fv5L3+LdjaFnQ@mail.gmail.com>
Subject: Re: [PATCH] perf tools:remove unneeded variable from perf_event_attr__fprintf()
To:     baomingtong001@208suo.com
Cc:     peterz@infradead.org, mingo@redhat.com, acme@kernel.org,
        mark.rutland@arm.com, alexander.shishkin@linux.intel.com,
        jolsa@kernel.org, namhyung@kernel.org, adrian.hunter@intel.com,
        anshuman.khandual@arm.com, linux-perf-users@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 13, 2023 at 11:25=E2=80=AFPM <baomingtong001@208suo.com> wrote:
>
> fix the following coccicheck warning:
>
> tools/perf/util/perf_event_attr_fprintf.c:97:5-8: Unneeded variable:
> "ret". Return "0".
>
> Signed-off-by: Mingtong Bao <baomingtong001@208suo.com>

Acked-by: Ian Rogers <irogers@google.com>

Thanks,
Ian

> ---
>   tools/perf/util/perf_event_attr_fprintf.c | 3 +--
>   1 file changed, 1 insertion(+), 2 deletions(-)
>
> diff --git a/tools/perf/util/perf_event_attr_fprintf.c
> b/tools/perf/util/perf_event_attr_fprintf.c
> index 7e5e7b30510d..4a8f625b80c7 100644
> --- a/tools/perf/util/perf_event_attr_fprintf.c
> +++ b/tools/perf/util/perf_event_attr_fprintf.c
> @@ -94,7 +94,6 @@ int perf_event_attr__fprintf(FILE *fp, struct
> perf_event_attr *attr,
>                    attr__fprintf_f attr__fprintf, void *priv)
>   {
>       char buf[BUF_SIZE];
> -    int ret =3D 0;
>
>       PRINT_ATTRf(type, p_unsigned);
>       PRINT_ATTRf(size, p_unsigned);
> @@ -155,5 +154,5 @@ int perf_event_attr__fprintf(FILE *fp, struct
> perf_event_attr *attr,
>       PRINT_ATTRf(aux_sample_size, p_unsigned);
>       PRINT_ATTRf(sig_data, p_unsigned);
>
> -    return ret;
> +    return 0;
>   }
