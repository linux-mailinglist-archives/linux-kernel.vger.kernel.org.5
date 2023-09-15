Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2990B7A2441
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Sep 2023 19:06:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234981AbjIORFl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Sep 2023 13:05:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56560 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235290AbjIORFO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Sep 2023 13:05:14 -0400
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com [IPv6:2a00:1450:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 12748270B
        for <linux-kernel@vger.kernel.org>; Fri, 15 Sep 2023 10:04:41 -0700 (PDT)
Received: by mail-wm1-x329.google.com with SMTP id 5b1f17b1804b1-4047c6ec21dso3075e9.0
        for <linux-kernel@vger.kernel.org>; Fri, 15 Sep 2023 10:04:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1694797479; x=1695402279; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LlAvjtLPcGmDg4A7voaF5Wo0HxRPXZyKmdzluEIsWow=;
        b=mug5uoFyuMNWFd1336n+BAfpL49sRARFE/++qKubqYNlg/SQB6DRYQW5oX9iZb4wif
         irEws6SLUYQRfH6S6rKGM8oRfI3Hl+qxwBd0uPl1KYuqpT/IjBBEHLBqPlUBqSJTWYn0
         H4J/30GSOQEibweMuGNo+gk7y0wZF6vLEC2gFhaOomHGu47KD6Cfa7gCr7wGnWzPzyHu
         hIt8uu6ozlNgawUi48BphAZec1zwpAHSmqZlQXx7gxxMjZbZ5bqYZ3AGqxmwfs0eNFtq
         UhechiHgO0aIczmaVgmU8mTjAyHWx6eui6bkSG8Xw617mgDKdiErCbV6LCsfWxXCPCRX
         NM4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694797479; x=1695402279;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=LlAvjtLPcGmDg4A7voaF5Wo0HxRPXZyKmdzluEIsWow=;
        b=kJoJNZ898pLcmE0HB3IKF77wsjH5keX40Hd2aQPnhKYCdnHHzQRfu1Lfmw9tb9/WT6
         ScAQAHro70DgzWjM0LsUW1QfVKyKWg2Jqx4akHQogb4rfval3nzYwafmvSGhZmwEu8ln
         5/2jYaEg3Hz9kYuq1YOxyx4V+ZGlshu+fNS1fIyOZGjWoVU1lTV47usUeiuQMXYWefBK
         R4KKLkji3xvsNDUK8Em3NTnXHr1gqrmXMuaJ/08XNtmhj39EBmXMoF2/tV4AQcn95h/O
         AKEaGUJP6XWxQS3Q3pkfgOELVsJ3LjymjF6HsnxI6muTe9U5vBGbMFA3Oc3QvrlgP2Kk
         QPxQ==
X-Gm-Message-State: AOJu0YxdldsVaUf4j8u7n4wBK2h9pJheGgpKlzZ6EmagLhTUzWJaN8eu
        p6se1rdixDVLvZWTCZdS0iQfVd4JBad0xf9yg/obKA==
X-Google-Smtp-Source: AGHT+IEonzgZqc+V81TNYkvowwdDOWM/CYqm2sY+5KYoHV7zxqDLiUjikh2qIP4geMp2o3XvkFv+g/ec00ROIhSqgW8=
X-Received: by 2002:a05:600c:1e07:b0:3f6:f4b:d4a6 with SMTP id
 ay7-20020a05600c1e0700b003f60f4bd4a6mr2391wmb.7.1694797479400; Fri, 15 Sep
 2023 10:04:39 -0700 (PDT)
MIME-Version: 1.0
References: <CA+fCnZePgv=V65t4FtJvcyKvhM6yA3amTbPnwc5Ft5YdzpeeRg@mail.gmail.com>
 <20230915024559.32806-1-haibo.li@mediatek.com> <CA+fCnZfuaovc4fk6Z+p1haLk7iemgtpF522sej3oWYARhBYYUQ@mail.gmail.com>
In-Reply-To: <CA+fCnZfuaovc4fk6Z+p1haLk7iemgtpF522sej3oWYARhBYYUQ@mail.gmail.com>
From:   Jann Horn <jannh@google.com>
Date:   Fri, 15 Sep 2023 19:04:00 +0200
Message-ID: <CAG48ez3GSubTFA8+hw=YDZoVHC79JVwNi+xFTQt9ssy_+O1aaw@mail.gmail.com>
Subject: Re: [PATCH] kasan:fix access invalid shadow address when input is illegal
To:     Andrey Konovalov <andreyknvl@gmail.com>
Cc:     Haibo Li <haibo.li@mediatek.com>, akpm@linux-foundation.org,
        angelogioacchino.delregno@collabora.com, dvyukov@google.com,
        glider@google.com, kasan-dev@googlegroups.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-mediatek@lists.infradead.org, linux-mm@kvack.org,
        mark.rutland@arm.com, matthias.bgg@gmail.com,
        ryabinin.a.a@gmail.com, vincenzo.frascino@arm.com,
        xiaoming.yu@mediatek.com
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

On Fri, Sep 15, 2023 at 6:51=E2=80=AFPM Andrey Konovalov <andreyknvl@gmail.=
com> wrote:
> On Fri, Sep 15, 2023 at 4:46=E2=80=AFAM 'Haibo Li' via kasan-dev
> <kasan-dev@googlegroups.com> wrote:
> >
> > The patch checks each shadow address,so it introduces extra overhead.
>
> Ack. Could still be fine, depends on the overhead.
>
> But if the message printed by kasan_non_canonical_hook is good enough
> for your use case, I would rather stick to that.
>
> > Now kasan_non_canonical_hook only works for CONFIG_KASAN_INLINE.
> >
> > And CONFIG_KASAN_OUTLINE is set in my case.
> >
> > Is it possible to make kasan_non_canonical_hook works for both
> > INLINE and OUTLINE by simply remove the "#ifdef CONFIG_KASAN_INLINE"?
>
> Yes, it should just work if you remove the ifdefs in mm/kasan/report.c
> and in include/linux/kasan.h.
>
> Jann, do you have any objections to enabling kasan_non_canonical_hook
> for the outline mode too?

No objections from me.
