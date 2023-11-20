Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A77647F1FC1
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Nov 2023 22:50:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232696AbjKTVu5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Nov 2023 16:50:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58868 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232913AbjKTVuh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Nov 2023 16:50:37 -0500
Received: from mail-pf1-x42f.google.com (mail-pf1-x42f.google.com [IPv6:2607:f8b0:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B80CB1BD6
        for <linux-kernel@vger.kernel.org>; Mon, 20 Nov 2023 13:49:44 -0800 (PST)
Received: by mail-pf1-x42f.google.com with SMTP id d2e1a72fcca58-6c320a821c4so4090229b3a.2
        for <linux-kernel@vger.kernel.org>; Mon, 20 Nov 2023 13:49:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1700516984; x=1701121784; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=dXdNO3H0aU38lJAHXmsd36+whUxtAu3qVmdPatddnpY=;
        b=boxaGvzrpucAoc65zI4Avrru+Shzbwo8jd7yszv2n+1a8YgTfswqcUqFNlkMTU5VKY
         NCzl8BhB2l7Weq/jYzQScygZcqcJGSQoGRHXdnzR/NWc/n5xnf9rxDjARNTikm/uuvSD
         d72MsyeKE8lGS/pptI+RHtmHLuxlrW0CxfV1tAqqytLg5J/5PIDi3kiwxPEaP71o0dxL
         98PiNQNxPlE3ZKVm3wJGxF7tEG0Iskw7OJDGzUvbGV9jTV1AISz8IBS98iG+5hF2Wm6y
         6J7BfPCk6OL5mCKyHAcAHVmGnLEDu0X0P6yo8d1RpoP9xkgkfrwjovugZWlZhnnpNrn1
         OFNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700516984; x=1701121784;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dXdNO3H0aU38lJAHXmsd36+whUxtAu3qVmdPatddnpY=;
        b=XHesOu1SUl8wYxmjOHEmppzsT1bmTMf6GUBqkxzD2gNfe0eSALgsBBNuN/VP+TdHpV
         TK0bBC6ymjRKika+zQr5MEMxmA513nLO7Ix/945+YqBvdSYvN5LwjD0j+25Qll4TQDDX
         Wh3Q6wqNVtRoqmGcuHAv1tumkP0aEstOi4mw2RIjom0K97QgrNtekcRSAxvXA8r3MbU2
         yFGriHfWudr5qP35hPfLuSfkC1TQb7j0Y/QCBSa8+0cNeQAUYkvTV/tuQUpzJec3/D1p
         zBNDFQfcBSKzX9soQ5Ct40nzIU+aCgPVSAeMMINPsEFt0hKTJ5X5uj6YVU0Gy25rRkWF
         NmnQ==
X-Gm-Message-State: AOJu0Ywwho9YwiAt78Dny26fPhPP5nMuRYkAxbrHr7asT8FODT5yjYO7
        bJXIHV2T+x87jkQuu4JVxbNbXw==
X-Google-Smtp-Source: AGHT+IHo4ANpQvv6aa2H17MSpU/clKN9d1EDtkl9s3C2H+RvfW2pPD7zyh9pv8/hNCFSpEBFd9e6ew==
X-Received: by 2002:a05:6a00:1516:b0:6cb:68d7:b1bc with SMTP id q22-20020a056a00151600b006cb68d7b1bcmr5001372pfu.30.1700516984127;
        Mon, 20 Nov 2023 13:49:44 -0800 (PST)
Received: from p14s ([2604:3d09:148c:c800:44fb:1793:dfea:b2d6])
        by smtp.gmail.com with ESMTPSA id u1-20020aa78381000000b006c69d4c9b24sm6539328pfm.167.2023.11.20.13.49.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Nov 2023 13:49:43 -0800 (PST)
Date:   Mon, 20 Nov 2023 14:49:40 -0700
From:   Mathieu Poirier <mathieu.poirier@linaro.org>
To:     "Iuliana Prodan (OSS)" <iuliana.prodan@oss.nxp.com>
Cc:     robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        conor+dt@kernel.org, Shawn Guo <shawnguo@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        alexander.stein@ew.tq-group.com,
        "S.J. Wang" <shengjiu.wang@nxp.com>,
        Fabio Estevam <festevam@gmail.com>, devicetree@vger.kernel.org,
        Daniel Baluta <daniel.baluta@nxp.com>,
        Mpuaudiosw <Mpuaudiosw@nxp.com>,
        Iuliana Prodan <iuliana.prodan@nxp.com>,
        linux-imx <linux-imx@nxp.com>, linux-remoteproc@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        LnxRevLi <LnxRevLi@nxp.com>
Subject: Re: [PATCH v4 0/2] Rpmsg support for i.MX DSP with resource table
Message-ID: <ZVvUdKxVpJesiIPg@p14s>
References: <20231013152731.23471-1-iuliana.prodan@oss.nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231013152731.23471-1-iuliana.prodan@oss.nxp.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 13, 2023 at 06:27:29PM +0300, Iuliana Prodan (OSS) wrote:
> From: Iuliana Prodan <iuliana.prodan@nxp.com>
> 
> These patches are needed in order to support rpmsg on DSP when a
> resource table is available.
> 
> Changes since v3:
>  - add reserve-memory nodes in imx8mp-evk.dts rather than .dtsi (patch 2/2)
> 
> Changes since v2:
>  - add newline between nodes in dtsi (patch 2/2)
> 
> Changes since v1:
>  - add missing bracket in dtsi (patch 2/2)
> 
> Iuliana Prodan (2):
>   remoteproc: imx_dsp_rproc: add mandatory find_loaded_rsc_table op
>   arm64: dts: imx8mp: add reserve-memory nodes for DSP
> 
>  arch/arm64/boot/dts/freescale/imx8mp-evk.dts | 22 ++++++++++++++++++++
>  drivers/remoteproc/imx_dsp_rproc.c           |  1 +
>  2 files changed, 23 insertions(+)
>

I have applied this set.

Thanks,
Mathieu

> -- 
> 2.17.1
> 
