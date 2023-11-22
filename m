Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B50C97F52EF
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Nov 2023 23:03:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344516AbjKVWD5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Nov 2023 17:03:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51726 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232342AbjKVWD4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Nov 2023 17:03:56 -0500
Received: from mail-pl1-x631.google.com (mail-pl1-x631.google.com [IPv6:2607:f8b0:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C850FB9;
        Wed, 22 Nov 2023 14:03:52 -0800 (PST)
Received: by mail-pl1-x631.google.com with SMTP id d9443c01a7336-1cc13149621so510555ad.1;
        Wed, 22 Nov 2023 14:03:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1700690632; x=1701295432; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=BzUdmEt+mfhkA4WMBT4hOVW/shcT3APClnfY/efVMMg=;
        b=bytJ2sUYh1vuBBr+VdRgaLKSKwXCO79jGTYR+Syk24EhXwKOlfCwPZGRawwpiuEZG/
         eI51OqA0fRyCWQDGa5iWZuo0u85YXFLPrJIjNcXpHEuzVeU/+lTJmKq2ftJy10su9DcB
         zwhidh2ZwuFfHLtAP96I1ba1ssFdQM9jrpLEPOSWbmbbPS+JmJiS89BsJ5hno57ApNTx
         XZPnP9zDEg4NXg5Z+8VAXhLCROQVZ42EWApJxhQSlVdHuTZUNtNbXi0pCMcFt/pSNYRn
         cC1biCL0UozbAh1KyGf1QMgWFW9OVAr7PTl4RJkinM4KGu9nfd/NdRgja/fazRzYAm6f
         tVlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700690632; x=1701295432;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BzUdmEt+mfhkA4WMBT4hOVW/shcT3APClnfY/efVMMg=;
        b=qeOKLpBLqRyAVhGbgyQ+hllC+mtS9lx2FkHnRS0l/y1s8WwsrWFK5BjmZRdcHlMxav
         IuseuHwyOpI2/PBZaN/qRmKGfLVYDKjA87qLaIZtkIJf3TwwTGnfwLjtYZE2hwWxkKSV
         d+WSr4PENiqifVMCdVetS1HUnryxtX5P58N9mk/S27AuJYOEVQ67d+UX6hLAleY79Gt1
         nHTOdgVuWAgs3lMXpmVhrwcTrUfNmts22gNrO0xpWTyxyU+cHrfX6N/cwMNLfQSMFh7/
         RGJ2Ik47jm8jM/aPVC6IkNeUhH54HC0lPj19tZzSIM7ihYY6rZaiyYHb+x1g/tT6BOw/
         jrRQ==
X-Gm-Message-State: AOJu0Yw6iAedBnyGes55OS2B1Yz2Nn28oVVvQSR9U7s+7ats/qwKnZJv
        TVr9sNwU49NxFO7LyH6cp4M=
X-Google-Smtp-Source: AGHT+IEIVCLgqhwIJn0dBf/Px/VmPoGdJ1j+nVTsrTLiZhPO5R7mTxsSQGYbXQ1dEZRGQsQzTSoHUQ==
X-Received: by 2002:a17:903:1c5:b0:1ce:5b6e:bae1 with SMTP id e5-20020a17090301c500b001ce5b6ebae1mr4113036plh.3.1700690632066;
        Wed, 22 Nov 2023 14:03:52 -0800 (PST)
Received: from hoboy.vegasvil.org ([2601:640:8000:54:e2d5:5eff:fea5:802f])
        by smtp.gmail.com with ESMTPSA id v8-20020a170902b7c800b001c452f827casm161021plz.257.2023.11.22.14.03.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Nov 2023 14:03:51 -0800 (PST)
Date:   Wed, 22 Nov 2023 14:03:49 -0800
From:   Richard Cochran <richardcochran@gmail.com>
To:     Sagi Maimon <maimon.sagi@gmail.com>
Cc:     reibax@gmail.com, davem@davemloft.net, rrameshbabu@nvidia.com,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1] ptp: add PTP_MULTI_CLOCK_GET ioctl
Message-ID: <ZV56xVnM2ii4Vwks@hoboy.vegasvil.org>
References: <20231122074352.473943-1-maimon.sagi@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231122074352.473943-1-maimon.sagi@gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 22, 2023 at 09:43:52AM +0200, Sagi Maimon wrote:

> @@ -226,6 +238,7 @@ struct ptp_pin_desc {
>  	_IOWR(PTP_CLK_MAGIC, 18, struct ptp_sys_offset_extended)
>  #define PTP_MASK_CLEAR_ALL  _IO(PTP_CLK_MAGIC, 19)
>  #define PTP_MASK_EN_SINGLE  _IOW(PTP_CLK_MAGIC, 20, unsigned int)
> +#define PTP_MULTI_CLOCK_GET _IOWR(PTP_CLK_MAGIC, 21, struct ptp_multi_clock_get)

I like the idea, but let's have it as a new system call.

The system call will accept a list of clockid_t.

That would allow getting CLOCK_MONOTONIC and PHC time stamps, for example.

Thanks,
Richard
