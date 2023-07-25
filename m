Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0A56C760B31
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jul 2023 09:09:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231859AbjGYHJU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Jul 2023 03:09:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37450 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229689AbjGYHJS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Jul 2023 03:09:18 -0400
Received: from mail-pl1-x62d.google.com (mail-pl1-x62d.google.com [IPv6:2607:f8b0:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 45255BF
        for <linux-kernel@vger.kernel.org>; Tue, 25 Jul 2023 00:09:17 -0700 (PDT)
Received: by mail-pl1-x62d.google.com with SMTP id d9443c01a7336-1bb8e45185bso11362615ad.1
        for <linux-kernel@vger.kernel.org>; Tue, 25 Jul 2023 00:09:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1690268957; x=1690873757;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=JIQ8MXgj79FPzxbU+Oz451tZts6uK1mso7WDqsxExFY=;
        b=VfntkoCSVssXo9LyVkGrt2TjunbWhF2qI/ykhbvzXpC9QmOrjiIdmtvZR/ssn8+Q1W
         uKQI3M1s0Uo8nufkszQL5PlNxyQrSbsDGQqFJBErhYh4k0XjilNPlVjWbvs1kGU9ymvt
         LPdeD7WxsbmnJDmAJSFZgj3y+nQlv1qn85ECPP47p5eMhWBffwI5DiGHmFBU4QTLouax
         UYG2osFUGhVt6Py0/Bo8TrqsjEXtKadDvJxf0sRLJwCT8UCtvfyTHRk2S3kW+qoVSWCv
         QwGo+WsR7TlD5JRpQyoD2EXZgk6dMbMVrXrDwFeQR1gbY2Rz7jly+gL0qfmRAHTCtJ/m
         IV2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690268957; x=1690873757;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JIQ8MXgj79FPzxbU+Oz451tZts6uK1mso7WDqsxExFY=;
        b=G9lYwgty96m41RwRQcfjXtptNQkrQFXEC+FLAGQevIdvsuaE+L9LD16L7UOx3wEy62
         4aNGsVw0D/tFA4uMyDc/hayo5E1dKvqanyDvrGSLbImNxRCU34wCSbhQtVqJQx0DWFQJ
         VUEN7XA5f/5FFZb2qhZIwNpsHlKkOAP1tMO8M4CFEofTD+47721FRyFoFfsbcoKcKuR+
         aOIRT6MdqSGCfKvb5bink6vJTiU/snM5qjBIIGURiWV40HpxZZjUkVVQIMRbQ8mVH6qQ
         32s4LM3EfuKfofzm9Wk9GPSGfH6k8unjusX3GE8TmvceIXJsCPRhXM4zm7n6yXYYdPMs
         Wa0w==
X-Gm-Message-State: ABy/qLYHV7rrFmMojMVgjYNOkhDz3l7oN9iJzUQDR1Z5t88P5BvSKVEL
        R8M/2X68sDVYVBHwXbW578jdMQ==
X-Google-Smtp-Source: APBJJlH8GuZfYFneyMg85Bl3e/BeTCnIRoDterkLPKXOwUe47EpC07JsTIRlFxwn8ihA2rpmJFhqeQ==
X-Received: by 2002:a17:902:ea04:b0:1b8:b3f9:58e5 with SMTP id s4-20020a170902ea0400b001b8b3f958e5mr12453743plg.38.1690268956688;
        Tue, 25 Jul 2023 00:09:16 -0700 (PDT)
Received: from localhost ([122.172.87.195])
        by smtp.gmail.com with ESMTPSA id l2-20020a170902f68200b001b89536974bsm10201845plg.202.2023.07.25.00.09.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Jul 2023 00:09:16 -0700 (PDT)
Date:   Tue, 25 Jul 2023 12:39:14 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Jan Beulich <jbeulich@suse.com>
Cc:     Vincent Guittot <vincent.guittot@linaro.org>,
        Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>,
        stratos-dev@op-lists.linaro.org,
        Erik Schilling <erik.schilling@linaro.org>,
        Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        xen-devel@lists.xenproject.org, linux-kernel@vger.kernel.org,
        Juergen Gross <jgross@suse.com>,
        Stefano Stabellini <sstabellini@kernel.org>,
        Oleksandr Tyshchenko <oleksandr_tyshchenko@epam.com>
Subject: Re: [PATCH V3 1/2] xen: Update dm_op.h from Xen public header
Message-ID: <20230725070914.m3dxlokedrgjlgcu@vireshk-i7>
References: <ffae9d7021829fea19fd93fda3c30b52b0af923e.1690190453.git.viresh.kumar@linaro.org>
 <1498bef6-ded0-1b1f-a5ca-e8755800b489@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1498bef6-ded0-1b1f-a5ca-e8755800b489@suse.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 25-07-23, 09:04, Jan Beulich wrote:
> On 25.07.2023 08:47, Viresh Kumar wrote:
> > +struct xen_dm_op {
> > +    uint32_t op;
> > +    uint32_t pad;
> > +    union {
> > +        struct xen_dm_op_create_ioreq_server create_ioreq_server;
> > +        struct xen_dm_op_get_ioreq_server_info get_ioreq_server_info;
> > +        struct xen_dm_op_ioreq_server_range map_io_range_to_ioreq_server;
> > +        struct xen_dm_op_ioreq_server_range unmap_io_range_from_ioreq_server;
> > +        struct xen_dm_op_set_ioreq_server_state set_ioreq_server_state;
> > +        struct xen_dm_op_destroy_ioreq_server destroy_ioreq_server;
> > +        struct xen_dm_op_track_dirty_vram track_dirty_vram;
> > +        struct xen_dm_op_set_pci_intx_level set_pci_intx_level;
> > +        struct xen_dm_op_set_isa_irq_level set_isa_irq_level;
> > +        struct xen_dm_op_set_irq_level set_irq_level;
> > +        struct xen_dm_op_set_pci_link_route set_pci_link_route;
> > +        struct xen_dm_op_modified_memory modified_memory;
> > +        struct xen_dm_op_set_mem_type set_mem_type;
> > +        struct xen_dm_op_inject_event inject_event;
> > +        struct xen_dm_op_inject_msi inject_msi;
> > +        struct xen_dm_op_map_mem_type_to_ioreq_server map_mem_type_to_ioreq_server;
> > +        struct xen_dm_op_remote_shutdown remote_shutdown;
> > +        struct xen_dm_op_relocate_memory relocate_memory;
> > +        struct xen_dm_op_pin_memory_cacheattr pin_memory_cacheattr;
> > +        struct xen_dm_op_nr_vcpus nr_vcpus;
> > +    } u;
> > +};
> 
> Is sync-ing for the sake of sync-ing really useful? For example, are any
> of the ioreq server elements halfway likely to ever be used in the kernel?

The only field, out of the union, I am using for now is:

        struct xen_dm_op_set_irq_level set_irq_level;

I am not sure if some of the others are going to be used or not in the
future.

FWIW, I am also looking at solving a similar problem for Ioeventfds
(kick from guest to backend) and may end up using a few more of these.
But they can very well be contained in that patchset.

-- 
viresh
