Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7DB9D813704
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Dec 2023 17:55:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229994AbjLNQzU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Dec 2023 11:55:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42642 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229743AbjLNQzR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Dec 2023 11:55:17 -0500
Received: from mail-pj1-x1030.google.com (mail-pj1-x1030.google.com [IPv6:2607:f8b0:4864:20::1030])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D6D7C125;
        Thu, 14 Dec 2023 08:55:23 -0800 (PST)
Received: by mail-pj1-x1030.google.com with SMTP id 98e67ed59e1d1-28b0a9876c8so420467a91.3;
        Thu, 14 Dec 2023 08:55:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1702572923; x=1703177723; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=MAfq8J8C5KAtCB8rcO3YT1HYm/yjjDzGk9Gqq0ijzyA=;
        b=IokwtgynXv0/38qvqdyZ8dyrW+rSwppJt13rCpCRdRp0LkvKV13PocAYsf3DXG0dXm
         H0rmRNiX73yLijpCBbJVXTPjoWStov+52kVRLvoq31R4Hc75MHREdGVYgkfJcr4D+Tzw
         wbbwOUA6kU/WZwxtXAUMXlK4rfMV7sQM97mSqmzO8HsPf0vj2Efu1yljw9LsEc4OqqiT
         TVTzPSibYfAW7rDxdddJMRq2NYosXfvzU7FRSIr+HFqSmZG2e5WnGeEcbzRTvnAPtn5r
         F+zYnWxugECyggEywauQPpfOn33nRh5E89QcoKhTleC6Z17LqTFW/bz+FFUHf7bCBBv3
         vpfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702572923; x=1703177723;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MAfq8J8C5KAtCB8rcO3YT1HYm/yjjDzGk9Gqq0ijzyA=;
        b=p8yixv5pl7vDL3oEGDrRn14aDC7w0kQyJzop9wZaLjWMLitjKeAAHhDn2qarKzHaGh
         aQ2mtnMHX/fexh84ZbUC2KZLKMR0Wt4QrAgisXY44NBMutXPoQdamHVQ0/Iq5LAp6lrf
         XACStiz6FAo/tl01XgTjAxBWw9adWQr8tMkfVd4hfXmC9NUhThI9pcKDHpZ+AGfCqt2k
         cquzvj0NPbG2hCDU4zhWy9Ia+MQ17jCi5+AofYCMAqqteb4bNhoGqovBn2NeqAoLil+7
         4nL9ojkaecA//JTNatzLKZpkAOd5WBXI3OlfATFXjvAj4yIOOsjAw1UVqD7AcHmVu502
         KMqg==
X-Gm-Message-State: AOJu0YzjW09iJt1yGrwAG5v7XIRHuSYc1MX/9ytfsORbKyiwo7G4CA7u
        QaaY8zCBG6wXrGrHi7zOQ9HkTPHOKXbJhQ==
X-Google-Smtp-Source: AGHT+IF7MooXa4kxbQW00+77DwdpwEn1ms3nqj2gxkPcOMCX1QO8nz22V4Z7dd0pF5kA1bOSrP7nXw==
X-Received: by 2002:a17:90a:5797:b0:286:6cc1:5fde with SMTP id g23-20020a17090a579700b002866cc15fdemr4833396pji.97.1702572923165;
        Thu, 14 Dec 2023 08:55:23 -0800 (PST)
Received: from Gentoo ([117.189.237.103])
        by smtp.gmail.com with ESMTPSA id oe16-20020a17090b395000b0028b21d24ba6sm277441pjb.15.2023.12.14.08.55.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Dec 2023 08:55:22 -0800 (PST)
Date:   Fri, 15 Dec 2023 00:55:08 +0800
From:   Jianhua Lu <lujianhua000@gmail.com>
To:     Mark Brown <broonie@kernel.org>
Cc:     Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Banajit Goswami <bgoswami@quicinc.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>, alsa-devel@alsa-project.org,
        linux-sound@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 1/4] ASoC: qcom: common: Add qcom_snd_tdm_hw_params
 function
Message-ID: <ZXszbA5fVq2AMjEb@Gentoo>
References: <20231213123556.20469-1-lujianhua000@gmail.com>
 <7b13b8b6-9048-48a3-b1a1-e62de88e8171@sirena.org.uk>
 <ZXsklsO7nOqBFgzt@Gentoo>
 <bee0ab28-6bd3-4904-8afc-44fe7ddacb79@sirena.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <bee0ab28-6bd3-4904-8afc-44fe7ddacb79@sirena.org.uk>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 14, 2023 at 03:56:52PM +0000, Mark Brown wrote:
> On Thu, Dec 14, 2023 at 11:51:50PM +0800, Jianhua Lu wrote:
> > On Thu, Dec 14, 2023 at 11:11:06AM +0000, Mark Brown wrote:
> 
> > > The expectation is that TDM is set up by the machine driver, not from
> > > hw_params - if the TDM setup can be changed from within hw_params then
> > > it's hard to see how it's going to interact well with other TDM users on
> > > the bus.  More usually hw_params() would be influenced by the setup done
> > > in set_tdm_slot().
> 
> > Currently, qcom TDM setup need to read hw_params, if we want to move it
> > to machine driver, we must hardcode some params, but it will reduce reduce
> > readability.
> 
> What makes you say that TDM setup needs to read hw_params?

qcom_snd_tdm_hw_params function read PCM_FORMAT to set slot_width value, read
channels to set rx_mask value.


