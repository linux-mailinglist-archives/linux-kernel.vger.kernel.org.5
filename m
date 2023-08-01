Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7A16076BAE0
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Aug 2023 19:13:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233595AbjHARNZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Aug 2023 13:13:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54840 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234485AbjHARM4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Aug 2023 13:12:56 -0400
Received: from mail-vs1-xe2c.google.com (mail-vs1-xe2c.google.com [IPv6:2607:f8b0:4864:20::e2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 76CFD1BCF;
        Tue,  1 Aug 2023 10:12:55 -0700 (PDT)
Received: by mail-vs1-xe2c.google.com with SMTP id ada2fe7eead31-444f9c0b2a4so1978099137.1;
        Tue, 01 Aug 2023 10:12:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1690909974; x=1691514774;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=tjQ83+bP/eZvrnu5mLPteL9v32upNHucn015ldMT4Lg=;
        b=eqleB+PpZKRzf07CkM3xQAVn2NofBi6SMHQMVVOvtjj1yAdQkkEpzST4P2npF+ejbz
         6OeHxWZxrhXtqLOSpyOOfUpXFH2lHhWamSLonMZ1o9NLYn5M31P6SwoZhQMpsBD3Rgxi
         jKQMJxbGcSSl685ayD3GcRoQfH5mg2NTm8mJ0XSQfkMgIrKRafZUto7la0ReRcyYsYF5
         6g7JxTndHY8g7HTBuN5JR1VCzQCKdRmiz2umjOQr40oPXi6MbozGZp1POTJ+c2RgDyqb
         MBwz+LZfTd0zNq7XYymhuV448iJei5cgunB3imBi/pb/Bc6n3nGlkvRDpu8PdAC/v1zX
         /Muw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690909974; x=1691514774;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=tjQ83+bP/eZvrnu5mLPteL9v32upNHucn015ldMT4Lg=;
        b=c/7OWAmg4jJFCgN8GNPQajiTp9h3LbxbsrQnuIYB9b9p/bolPjPxnotOgIqoj8zIhz
         XbXkAOIdDd4agbydg986vj235RrSAKGcrslFIQOs+YIoT2TNRW2RHVquxYwOKAF6QcPR
         mSF+eXEqKMC3n3DPF1pNaeUD5beKe11Bqm86fE9QroyWYUenO7IQQjXaCC/IdKLonweW
         Kg9S3s5yhVaRRgk8nTbXeRMhemZvpOBlLN1deVEdxzUWmuJ++n7nY7HTadSFuVunWYFA
         umzqmvQKwFK8cVwPa49wVZGdOvjUBNZ/chAGYCU9yRXiXgAFY0H8Q4KeoLAxks0a+llS
         LxvQ==
X-Gm-Message-State: ABy/qLbWSMqoZnaW7m/jHKw77HNdwL8Q0Q3MfHGIwQVuACgAydGeDqVo
        obj+j48w8zLUJ3W8j+D9WxOvMYrVAMdrPslN73s=
X-Google-Smtp-Source: APBJJlGnBieFRVxRgawFgQeh8nMkgg8VXaX2ymYIkKzgsSDMdNymXxpqVlXrzhUS5zrV6ie9HEECZVtXFldDoVWXz7k=
X-Received: by 2002:a05:6102:8f:b0:447:48ab:cfe9 with SMTP id
 t15-20020a056102008f00b0044748abcfe9mr2671039vsp.5.1690909974270; Tue, 01 Aug
 2023 10:12:54 -0700 (PDT)
MIME-Version: 1.0
References: <1690598115-26287-1-git-send-email-quic_pintu@quicinc.com> <20230731112155.GA3662@lst.de>
In-Reply-To: <20230731112155.GA3662@lst.de>
From:   Pintu Agarwal <pintu.ping@gmail.com>
Date:   Tue, 1 Aug 2023 22:42:42 +0530
Message-ID: <CAOuPNLjnfq1JefngtNrg0Q+JdMTSRz+eEqxGQJFfx9+af+k9WA@mail.gmail.com>
Subject: Re: [PATCH v2] dma-contiguous: define proper name for global cma region
To:     Christoph Hellwig <hch@lst.de>
Cc:     Pintu Kumar <quic_pintu@quicinc.com>, linux-kernel@vger.kernel.org,
        akpm@linux-foundation.org, linux-mm@kvack.org,
        m.szyprowski@samsung.com, robin.murphy@arm.com,
        iommu@lists.linux.dev, Sumit Semwal <sumit.semwal@linaro.org>,
        Benjamin Gaignard <benjamin.gaignard@collabora.com>,
        Liam Mark <lmark@codeaurora.org>,
        Laura Abbott <labbott@redhat.com>,
        Brian Starkey <Brian.Starkey@arm.com>,
        John Stultz <jstultz@google.com>,
        =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
        linux-media@vger.kernel.org, dri-devel@lists.freedesktop.org,
        linaro-mm-sig@lists.linaro.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Christoph,
Thank you so much for your review and comments.

On Mon, 31 Jul 2023 at 16:51, Christoph Hellwig <hch@lst.de> wrote:
>
> Hi Pintu,
>
> On Sat, Jul 29, 2023 at 08:05:15AM +0530, Pintu Kumar wrote:
> > The current global cma region name defined as "reserved"
> > which is misleading, creates confusion and too generic.
> >
> > Also, the default cma allocation happens from global cma region,
> > so, if one has to figure out all allocations happening from
> > global cma region, this seems easier.
> >
> > Thus, change the name from "reserved" to "global-cma-region".
>
> I agree that reserved is not a very useful name.  Unfortuately the
> name of the region leaks to userspace through cma_heap.
>
> So I think we need prep patches to hardcode "reserved" in
> add_default_cma_heap first, and then remove the cma_get_name
> first.

Sorry, but I could not fully understand your comments.
Can you please elaborate a little more what changes are required in
cma_heap if we change "reserved" to "global-cma-region" ?
You mean to say there are userspace tools that rely on this "reserved"
naming for global cma ?
