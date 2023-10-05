Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E869D7B9E09
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Oct 2023 16:01:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231740AbjJEN6v (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Oct 2023 09:58:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59732 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231843AbjJEN5G (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Oct 2023 09:57:06 -0400
Received: from mail-pl1-x62e.google.com (mail-pl1-x62e.google.com [IPv6:2607:f8b0:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2FD7A1FEDC
        for <linux-kernel@vger.kernel.org>; Thu,  5 Oct 2023 03:07:26 -0700 (PDT)
Received: by mail-pl1-x62e.google.com with SMTP id d9443c01a7336-1c760b34d25so5568065ad.3
        for <linux-kernel@vger.kernel.org>; Thu, 05 Oct 2023 03:07:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1696500445; x=1697105245; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=uLWFeSVond74tkZOqvEba086Qve4qLpMCCHqTH1lxBk=;
        b=GpVYS4pZEiwJT5pw2AgbMw4SZUHWUAPvk4H75nkD/3yJRG3ZUJ2QhoSkboTpIMRM+v
         UXEnD7FEki+a4Rqa8yd0PTY7clvIQdtlRCaPnN2pDrDeIy7bfT03K8WM3msBJ0b/UdRs
         4eymBgHI485umVGErQXZGEtL13KqS+tveLCiYYat4gA5gghdTm2ka77yRosbEjG/EsNo
         GY2c6fx2Kat8bGBN12Vlhnceiwk77X8d1IvigASH1E54seiH7FocwinfLd5M2XnXyIQ3
         X8EZq+tfqAoaTLGhmZYrGdERD5BOp0f6qaCs71Xy3a7nOfWLMerW4LDHtuCkRba31L64
         HleQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696500445; x=1697105245;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uLWFeSVond74tkZOqvEba086Qve4qLpMCCHqTH1lxBk=;
        b=R6rmRqsedgGexhj2ChjlKH6e8DnPYLo1Odcv+S7BTycQv/gd5Joy/IVDvJ7yTrfUBT
         b22SUFCE5DxZnbG1jQX0abq/io47aXCJojAUQ4GlNy85LjEPwCB7+MVwkeAq1a74hI9r
         XdVTI4cnGFMIo+vwAkw0sbXgyiddCBJENtLPltFVF5idmxestE72uWJcL36WwsJBDt/b
         HvKrkjwuvVxoDaBWTagNm51pJmH3oJuX9Pfuz0hcsTPwHnfp/fZeRt9WanQOvXjsjnbG
         cz4XlFSFwJHBIHTxrsSbQTYlTgDOpLoKcbDq07RtU/I9ltT2Ku3q1vVoHMycpeOr449t
         /tRw==
X-Gm-Message-State: AOJu0YyGbequAXk4h8RSOlovsuKfd8+hLoRhW2D3CI1SvRHp+GWG1MJi
        iGAGIPaIj/hij4J3JkJYlzH9gQ==
X-Google-Smtp-Source: AGHT+IHDCQEsjSU/8o8lSlZdriKzqJWmPSyvLf2DgrNbq7AdX5GK/V8t/tO5R5jRak2/UJfY8QjkJQ==
X-Received: by 2002:a17:902:7d92:b0:1c3:2ee6:3802 with SMTP id a18-20020a1709027d9200b001c32ee63802mr3845036plm.47.1696500445611;
        Thu, 05 Oct 2023 03:07:25 -0700 (PDT)
Received: from localhost ([122.172.81.92])
        by smtp.gmail.com with ESMTPSA id p20-20020a170902ead400b001c3e732b8dbsm1244304pld.168.2023.10.05.03.07.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Oct 2023 03:07:24 -0700 (PDT)
Date:   Thu, 5 Oct 2023 15:37:23 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Juergen Gross <jgross@suse.com>
Cc:     Stefano Stabellini <sstabellini@kernel.org>,
        Oleksandr Tyshchenko <oleksandr_tyshchenko@epam.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>,
        stratos-dev@op-lists.linaro.org,
        Erik Schilling <erik.schilling@linaro.org>,
        Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        linux-kernel@vger.kernel.org, xen-devel@lists.xenproject.org
Subject: Re: [PATCH 2/2] xen: privcmd: Add support for ioeventfd
Message-ID: <20231005100723.krikk4oauyb4nm2d@vireshk-i7>
References: <cover.1693311370.git.viresh.kumar@linaro.org>
 <52b07a3861a34fb0deb6251bae8bd885815c6944.1693311370.git.viresh.kumar@linaro.org>
 <fb79fa9a-e91c-4bb7-8aee-c384b99df953@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <fb79fa9a-e91c-4bb7-8aee-c384b99df953@suse.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 29-09-23, 07:46, Juergen Gross wrote:
> This is populated from a __u64 field. Maybe make it uint64_t?

Checkpatch warns about this, will use u64 instead.

CHECK: Prefer kernel type 'u64' over 'uint64_t'
#124: FILE: drivers/xen/privcmd.c:1097:
+	uint64_t addr;

-- 
viresh
