Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E018F813549
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Dec 2023 16:52:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1573921AbjLNPwB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Dec 2023 10:52:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51278 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1573914AbjLNPv7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Dec 2023 10:51:59 -0500
Received: from mail-pl1-x630.google.com (mail-pl1-x630.google.com [IPv6:2607:f8b0:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E47C312E;
        Thu, 14 Dec 2023 07:52:05 -0800 (PST)
Received: by mail-pl1-x630.google.com with SMTP id d9443c01a7336-1d359f04514so9577995ad.2;
        Thu, 14 Dec 2023 07:52:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1702569125; x=1703173925; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=LJYbFg0YusLQd7kau+7yl+2+5aq7Aytpc7bFv1yVVFU=;
        b=dKQI+pKlbRNW/yvwOTkrGo0E62ygUEuf6NQy8Wxuk5Zph5lLp/mqUZ99xKZ7d/dyzM
         8mZiLmdSPD7UK/wjYIkq98u2nlfDecBmaWSqsZw/KSJXxJkljb0BF+LKFScaiVFF3pV6
         JguGHTw335/7/5PMmlOJF6HvxCkYoWO5UIDFlwT/xRJtWshFqwY0iFJzDcYV+tC4iakA
         lwvR6yill6ujcKxsRQ5mdtDy5dMc+JEinV/+e52imBetNxXbBdDfdAtuDKv9dC58BXoC
         ZPJKdNHyaHQXSejM2u00vvaosLg0lTSQVBnthtNUkp+b9EYveNsNyWZnEY1t45WcI1UH
         9JPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702569125; x=1703173925;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LJYbFg0YusLQd7kau+7yl+2+5aq7Aytpc7bFv1yVVFU=;
        b=v48HDSU960MG337EZg/cbYR4IPf8RzGNxZjjjck0OATwSy/KyokI+QTWdVD4gMK3FK
         qMPYLK5o49vrkwAUMx7vn0nhPDmE/STp/JeAx8WxKUyul6+02T2ge7IccF4z1GmYY4sh
         9zQHYKi02nX8KNv80hd6C9bTtHTmBUuFl8XWbG2Pd6E+4c6JTu67F+k2HF7M8STLjp3Y
         17hHDwRssvdvNXI7JP9/J+MqAuvpckt/9jkkkUccD/G6ET4/w9oZ1wW0KxcewhvASsVP
         C7Sy9G4d1t00bgYl7L+upGU+m9oA7CplvpnlXeYY/kvUmbsIzEDNBBQTpokiUqMiD7BS
         Cb1g==
X-Gm-Message-State: AOJu0YzNzXfigpgcwVaEpIIxjpwyxYXREdzwL3mdQa2MwrYd0WCwW9if
        1mRO5AMrkr1qzE97tze8xEkbMxLi3z9/fw==
X-Google-Smtp-Source: AGHT+IGLVtkXrMWtZzPCAej2kU9rW+T3NVD3Oj2+SwbxBlJMUum28HpOEywNDJUC+UADtGETmjTfLQ==
X-Received: by 2002:a17:90b:34a:b0:286:bd7a:9f7e with SMTP id fh10-20020a17090b034a00b00286bd7a9f7emr4439129pjb.29.1702569125260;
        Thu, 14 Dec 2023 07:52:05 -0800 (PST)
Received: from Gentoo ([117.189.237.103])
        by smtp.gmail.com with ESMTPSA id nd10-20020a17090b4cca00b0028af27eeaf1sm2784079pjb.36.2023.12.14.07.51.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Dec 2023 07:52:04 -0800 (PST)
Date:   Thu, 14 Dec 2023 23:51:50 +0800
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
Message-ID: <ZXsklsO7nOqBFgzt@Gentoo>
References: <20231213123556.20469-1-lujianhua000@gmail.com>
 <7b13b8b6-9048-48a3-b1a1-e62de88e8171@sirena.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7b13b8b6-9048-48a3-b1a1-e62de88e8171@sirena.org.uk>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 14, 2023 at 11:11:06AM +0000, Mark Brown wrote:
> On Wed, Dec 13, 2023 at 08:35:53PM +0800, Jianhua Lu wrote:
> 
> > Add qcom TDM setup function to support TDM ports for qcom platform.
> 
> > +int qcom_snd_tdm_hw_params(struct snd_pcm_substream *substream,
> > +			   struct snd_pcm_hw_params *params)
> > +{
> 
> ...
> 
> > +		ret = snd_soc_dai_set_tdm_slot(cpu_dai, tx_mask, rx_mask, slots, slot_width);
> > +		if (ret < 0) {
> 
> The expectation is that TDM is set up by the machine driver, not from
> hw_params - if the TDM setup can be changed from within hw_params then
> it's hard to see how it's going to interact well with other TDM users on
> the bus.  More usually hw_params() would be influenced by the setup done
> in set_tdm_slot().

Currently, qcom TDM setup need to read hw_params, if we want to move it
to machine driver, we must hardcode some params, but it will reduce reduce
readability.

