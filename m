Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2A1297BABE7
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Oct 2023 23:24:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231184AbjJEVYq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Oct 2023 17:24:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43166 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229750AbjJEVYo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Oct 2023 17:24:44 -0400
Received: from mail-lf1-x12a.google.com (mail-lf1-x12a.google.com [IPv6:2a00:1450:4864:20::12a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 10F019E
        for <linux-kernel@vger.kernel.org>; Thu,  5 Oct 2023 14:24:43 -0700 (PDT)
Received: by mail-lf1-x12a.google.com with SMTP id 2adb3069b0e04-50348c54439so613e87.1
        for <linux-kernel@vger.kernel.org>; Thu, 05 Oct 2023 14:24:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1696541081; x=1697145881; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HaepO8t9qhUeaSKJc3bNMlDRkxaen46XWRceHQFUez0=;
        b=icj7FDcOeaHdhirjHfO7ZwX7gRjJf7EQTND5WZRPahPXtBwfEYNyfVVB+LSI/Dh9HL
         ihl348LIcgkUeMeyIdH4+J8ieGZNOfdZjUkcv8BIfL4ZHIvkFMFneJo9jFzWjq3CvvRF
         NJJ3t6Rx8B3PtlE+zO/dv/oIthYui2BN0lVSe3wFnAgeG/hFm94aD15xN6HQrw8VwJFR
         CFk+uKJbO/FEHZoh9pMFlGKX8C21uAW2XzBdY175SP4fUM/0/7xnDneLlpBADqoVwmxY
         djaqeEx8n63NGe2YwdeujoVjzDFgzajyUTr/1tImWw7PF0AKVX+jQolucpS6EdR/oyUR
         U5Ag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696541081; x=1697145881;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HaepO8t9qhUeaSKJc3bNMlDRkxaen46XWRceHQFUez0=;
        b=ncsiLXI2ngW3bD6SsWZy1S5fLNE674+whY0TrTfoK16wasOzYy4J1k+S72mOnmECpx
         uIdXKLKeueeA7mXiuYfHMDckKQYXVKjddCiLxAACyqOFFjfwBpdgjhRsBk2GCKODGjKg
         alhBSsf6IcceHhhGmFbnco6Ekfy4hQrMdNULk0tkvVgoZg7KNrnYv9yTKytaD4rbCmwL
         HQgRfNFKfOpi1u4MXC5Dsx/xURPZY+vm366lEZ8FnOYeLGXz8O4VZ9aD+ClAGGlOgpl0
         4LrT9eU7DXJUd+BhIroEboCJ3dTG8dXmtDYCn6u1jrXcIAgbPAKz6B/JYFtlbvkUBMAx
         X2gw==
X-Gm-Message-State: AOJu0Yyi+fVPwwYppHVSXPvnOvzpLiIIeeE1XL8xHjKPKVIueVfHm6me
        6gX/Iq65XOXLqWBsyPvgpiA7aWrYUqwp4zxQEJy8Mw==
X-Google-Smtp-Source: AGHT+IGwjAsToi5gc7RhWC+svZLqKDlBw6l4RJI3YmEmmql4x5V+8FrGIUxzcWz0M1odhb6QMuJtaotLYnION36T/kM=
X-Received: by 2002:a19:f014:0:b0:502:c615:99b0 with SMTP id
 p20-20020a19f014000000b00502c61599b0mr66809lfc.4.1696541081106; Thu, 05 Oct
 2023 14:24:41 -0700 (PDT)
MIME-Version: 1.0
References: <20231002221909.2958708-1-irogers@google.com> <CAP-5=fX-VOeCkOJY5xeW67x0+A0tGAHM4VYBBz46L-g2eRCR+w@mail.gmail.com>
 <93afcf44-5f8b-49c1-abc5-5304cba5f991@intel.com>
In-Reply-To: <93afcf44-5f8b-49c1-abc5-5304cba5f991@intel.com>
From:   Ian Rogers <irogers@google.com>
Date:   Thu, 5 Oct 2023 14:24:29 -0700
Message-ID: <CAP-5=fXzcR6QKKhFG5PS1pFYi5JsO4AOUoH_-Bv0O+11YzEkkw@mail.gmail.com>
Subject: Re: [PATCH v1] perf intel-pt: pkt-decoder: Fix alignment issues
To:     Adrian Hunter <adrian.hunter@intel.com>
Cc:     Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Jiri Olsa <jolsa@kernel.org>, Miguel Ojeda <ojeda@kernel.org>,
        Liam Howlett <liam.howlett@oracle.com>,
        Namhyung Kim <namhyung@kernel.org>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 5, 2023 at 12:06=E2=80=AFPM Adrian Hunter <adrian.hunter@intel.=
com> wrote:
>
> On 5/10/23 18:48, Ian Rogers wrote:
> > On Mon, Oct 2, 2023 at 3:19=E2=80=AFPM Ian Rogers <irogers@google.com> =
wrote:
> >>
> >> The byte aligned buffer is cast to large types and dereferenced
> >> causing misaligned pointer warnings from undefined behavior sanitizer.
> >> Fix the alignment issues with memcpy which may require the
> >> introduction of temporaries.
> >>
> >> Signed-off-by: Ian Rogers <irogers@google.com>
> >> ---
> >
> > This is a relatively small change that fixes building with
> > -fsanitize=3Dalignment -fsanitize-undefined-trap-on-error. Adrian, as
> > this is Intel-PT could you take a look?
>
> Thanks! This has been down my list of things to do for ages,
> but using get_unaligned_le16() etc seems nicer.  I sent a patch
> set for that.

Thanks Adrian! Your patch set looks good and I think after Arnaldo's
comment is addressed we should go with it.

Ian

> >
> > Thanks,
> > Ian
> >
> >>  .../intel-pt-decoder/intel-pt-pkt-decoder.c   | 21 ++++++++++++------=
-
> >>  1 file changed, 14 insertions(+), 7 deletions(-)
> >>
> >> diff --git a/tools/perf/util/intel-pt-decoder/intel-pt-pkt-decoder.c b=
/tools/perf/util/intel-pt-decoder/intel-pt-pkt-decoder.c
> >> index af9710622a1f..28659874d84e 100644
> >> --- a/tools/perf/util/intel-pt-decoder/intel-pt-pkt-decoder.c
> >> +++ b/tools/perf/util/intel-pt-decoder/intel-pt-pkt-decoder.c
> >> @@ -83,7 +83,7 @@ static int intel_pt_get_long_tnt(const unsigned char=
 *buf, size_t len,
> >>         if (len < 8)
> >>                 return INTEL_PT_NEED_MORE_BYTES;
> >>
> >> -       payload =3D le64_to_cpu(*(uint64_t *)buf);
> >> +       memcpy_le64(&payload, buf, sizeof(payload));
> >>
> >>         for (count =3D 47; count; count--) {
> >>                 if (payload & BIT63)
> >> @@ -220,6 +220,8 @@ static int intel_pt_get_3byte(const unsigned char =
*buf, size_t len,
> >>  static int intel_pt_get_ptwrite(const unsigned char *buf, size_t len,
> >>                                 struct intel_pt_pkt *packet)
> >>  {
> >> +       uint32_t tmp;
> >> +
> >>         packet->count =3D (buf[1] >> 5) & 0x3;
> >>         packet->type =3D buf[1] & BIT(7) ? INTEL_PT_PTWRITE_IP :
> >>                                          INTEL_PT_PTWRITE;
> >> @@ -228,12 +230,13 @@ static int intel_pt_get_ptwrite(const unsigned c=
har *buf, size_t len,
> >>         case 0:
> >>                 if (len < 6)
> >>                         return INTEL_PT_NEED_MORE_BYTES;
> >> -               packet->payload =3D le32_to_cpu(*(uint32_t *)(buf + 2)=
);
> >> +               memcpy(&tmp, buf + 2, sizeof(tmp));
> >> +               packet->payload =3D le32_to_cpu(tmp);
> >>                 return 6;
> >>         case 1:
> >>                 if (len < 10)
> >>                         return INTEL_PT_NEED_MORE_BYTES;
> >> -               packet->payload =3D le64_to_cpu(*(uint64_t *)(buf + 2)=
);
> >> +               memcpy_le64(&packet->payload, buf + 2, sizeof(packet->=
payload));
> >>                 return 10;
> >>         default:
> >>                 return INTEL_PT_BAD_PACKET;
> >> @@ -258,7 +261,7 @@ static int intel_pt_get_mwait(const unsigned char =
*buf, size_t len,
> >>         if (len < 10)
> >>                 return INTEL_PT_NEED_MORE_BYTES;
> >>         packet->type =3D INTEL_PT_MWAIT;
> >> -       packet->payload =3D le64_to_cpu(*(uint64_t *)(buf + 2));
> >> +       memcpy_le64(&packet->payload, buf + 2, sizeof(packet->payload)=
);
> >>         return 10;
> >>  }
> >>
> >> @@ -454,6 +457,8 @@ static int intel_pt_get_ip(enum intel_pt_pkt_type =
type, unsigned int byte,
> >>                            struct intel_pt_pkt *packet)
> >>  {
> >>         int ip_len;
> >> +       uint16_t tmp16;
> >> +       uint32_t tmp32;
> >>
> >>         packet->count =3D byte >> 5;
> >>
> >> @@ -465,13 +470,15 @@ static int intel_pt_get_ip(enum intel_pt_pkt_typ=
e type, unsigned int byte,
> >>                 if (len < 3)
> >>                         return INTEL_PT_NEED_MORE_BYTES;
> >>                 ip_len =3D 2;
> >> -               packet->payload =3D le16_to_cpu(*(uint16_t *)(buf + 1)=
);
> >> +               memcpy(&tmp16, buf + 1, sizeof(tmp16));
> >> +               packet->payload =3D le16_to_cpu(tmp16);
> >>                 break;
> >>         case 2:
> >>                 if (len < 5)
> >>                         return INTEL_PT_NEED_MORE_BYTES;
> >>                 ip_len =3D 4;
> >> -               packet->payload =3D le32_to_cpu(*(uint32_t *)(buf + 1)=
);
> >> +               memcpy(&tmp32, buf + 1, sizeof(tmp32));
> >> +               packet->payload =3D le32_to_cpu(tmp32);
> >>                 break;
> >>         case 3:
> >>         case 4:
> >> @@ -484,7 +491,7 @@ static int intel_pt_get_ip(enum intel_pt_pkt_type =
type, unsigned int byte,
> >>                 if (len < 9)
> >>                         return INTEL_PT_NEED_MORE_BYTES;
> >>                 ip_len =3D 8;
> >> -               packet->payload =3D le64_to_cpu(*(uint64_t *)(buf + 1)=
);
> >> +               memcpy_le64(&packet->payload, buf + 1, sizeof(packet->=
payload));
> >>                 break;
> >>         default:
> >>                 return INTEL_PT_BAD_PACKET;
> >> --
> >> 2.42.0.582.g8ccd20d70d-goog
> >>
>
