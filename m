Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6C5597E9A85
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Nov 2023 11:45:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229717AbjKMKps (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Nov 2023 05:45:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47596 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229470AbjKMKpp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Nov 2023 05:45:45 -0500
Received: from mail-qt1-x830.google.com (mail-qt1-x830.google.com [IPv6:2607:f8b0:4864:20::830])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9593A10CC
        for <linux-kernel@vger.kernel.org>; Mon, 13 Nov 2023 02:45:41 -0800 (PST)
Received: by mail-qt1-x830.google.com with SMTP id d75a77b69052e-41eb4210383so25773291cf.0
        for <linux-kernel@vger.kernel.org>; Mon, 13 Nov 2023 02:45:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1699872340; x=1700477140; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=TN1rmKLKakodRU8vVvF98V6hyYkno3rpTcUXm2+n8BM=;
        b=luSXS7e6Z8SUJmwlHYRIRxCQbStKhN3ioFIUJSv14xIaPphTs/zXVGGF5jsyvfco6Q
         +WooBQkci//A+vI9bJOkp/m7fiQbfhJtGlOunlqzGRgFxMz/8KNQ1Sl4Z+C9E8UB/1VD
         9Vbn1PxTdEMfhDUBRk2l3XmfZ52UsU7PhSbTNbcb1MYxCJ7727c6Q54BlRtJAJl1qd/A
         cDVYvYNnqQyB3I4Twu94lBoL4ELhzP9aw6WwMoS9Sy5uRANyIXoK0oLG7oANr7zQeaSa
         Wlx+jF1Gwg0naODhVpscqu/MXebn6zWKScxvLTv6Zsshhw14rTQF6UiBm52GVG9dvsiE
         mVdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699872340; x=1700477140;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=TN1rmKLKakodRU8vVvF98V6hyYkno3rpTcUXm2+n8BM=;
        b=IcWPN/9Z4G7rFq64hqFmGDumwCfqw9ng0gSwxBsrkvZ43zo2is8ehMjS8QpYZPLwJ2
         zvI0s6DNj61/a3iZu1B8vXPsdr0TtChutWIec8fY/XxB9PAYO3qpnBakQjLQe1cEuHhn
         9yfIgxWJ2hsUAnPbQNTni49ms+eJ6o1h9JjBpq3qiVxhXBYm+WZ8Z9UNlJvPGWXlHHM9
         vUFYJa8m1/JtU9F8vFetpPRFA3tlFzMhdZc1aGJwb8JkLStg9wN9hKxWe+2o+ErJO/gg
         F+BaKHqtF6OYUKEHAhuNqvZiXR46N5GiAx4EJO2eUlJzT1V2Ta8PgBbUdjm8WEecEFur
         Ay8w==
X-Gm-Message-State: AOJu0YxM6cTU9JAuR7bomEYKaqgkwN1Pzk00uLVqgybe7iRi/yw7MfsY
        lIa1TB15DiJbTzTJ4FyE07QpEfvVOPXkzd6XpRGQVA==
X-Google-Smtp-Source: AGHT+IFmsD5BGHUGWSSpKkxuR05Uc/IqKa7Px+iY4SmEBuXuhs7yOIEciha9qKaJ+LfTi0ia9c0Mrvtjb4f0B7klUqM=
X-Received: by 2002:a0c:c583:0:b0:66d:36fb:474d with SMTP id
 a3-20020a0cc583000000b0066d36fb474dmr5788189qvj.1.1699872340544; Mon, 13 Nov
 2023 02:45:40 -0800 (PST)
MIME-Version: 1.0
References: <20231103160335.2464561-1-glider@google.com> <20231103160335.2464561-4-glider@google.com>
 <ZUVulBKVYK7cq2rJ@yury-ThinkPad> <CAG_fn=Vz9ihxLpkT9rxJB=3UfBdsn6HqYCn7aME6xz1SW1YSMg@mail.gmail.com>
In-Reply-To: <CAG_fn=Vz9ihxLpkT9rxJB=3UfBdsn6HqYCn7aME6xz1SW1YSMg@mail.gmail.com>
From:   Alexander Potapenko <glider@google.com>
Date:   Mon, 13 Nov 2023 11:45:00 +0100
Message-ID: <CAG_fn=UOQobY3_KryiJe-JgehMYRFDLWMomNFL0aHA0KDL_daA@mail.gmail.com>
Subject: Re: [PATCH v8 3/3] arm64: mte: add compression support to mteswap.c
To:     Yury Norov <yury.norov@gmail.com>
Cc:     catalin.marinas@arm.com, will@kernel.org, pcc@google.com,
        andreyknvl@gmail.com, andriy.shevchenko@linux.intel.com,
        aleksander.lobakin@intel.com, linux@rasmusvillemoes.dk,
        alexandru.elisei@arm.com, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, eugenis@google.com,
        syednwaris@gmail.com, william.gray@linaro.org
Content-Type: text/plain; charset="UTF-8"
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

> > >
> > >  void mte_free_tag_storage(char *storage)
> >
> > If you use a term 'free' here, the counter name should probably
> > reflect that.
>
> I still want to keep the terms "allocation/deallocation" in the
> user-facing code (in the /sys/ file) though.
> So renaming the counter here will cause a mismatch between its name
> and the stats output.

To move forward, I am going to send out v9 that addresses your
comments except for this one and for moving the conditionals inside
mte_compress() and mte_decompress().
Happy to discuss those three points further.
