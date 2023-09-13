Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6BBE779EDFE
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Sep 2023 18:10:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230000AbjIMQKt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Sep 2023 12:10:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52792 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229437AbjIMQKr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Sep 2023 12:10:47 -0400
Received: from lahtoruutu.iki.fi (lahtoruutu.iki.fi [IPv6:2a0b:5c81:1c1::37])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6351FB8;
        Wed, 13 Sep 2023 09:10:43 -0700 (PDT)
Received: from hillosipuli.retiisi.eu (dkzdf0gkyyyyyyyyyyyyt-3.rev.dnainternet.fi [IPv6:2001:14ba:4506:4f15::1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: sailus)
        by lahtoruutu.iki.fi (Postfix) with ESMTPSA id 4Rm55s1ZKdz49Q8K;
        Wed, 13 Sep 2023 19:10:41 +0300 (EEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi; s=lahtoruutu;
        t=1694621441;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=R4tbkmHfyipimkB/hD8ONV34s4sKnuYw+dMzeFzQs0o=;
        b=gzL/QkzOM748V8Y4D91yjPupeUcUAfj6alrDyNXJmvHmYBnB9ic7HULNBj4Um2Wvq3HOPW
        FKhNjpVTx5MgzwPIxfSwb9hWxSuKrhEIAaMRG8ESNoWAO5qgnBWcMM8nPn1eEvnL3vADUN
        zLPfluikLXyp5pKBMLZnko3y47vkpAHN4mj2tLOg3E1PfUwOb56CEcIYQ/ztFAQipI/KyX
        59cNrUbLrdbI490XO34SEdLokdH5l64T3xSosToJYQ2RCLr0o0XAbrzH8/E3HnJZafphuj
        rlzlJNaNVTxrFeMHFuzZhgnNRshXxv/26Q4B4jo59KexsHX5vRCoc1i0ZiNr5g==
ARC-Seal: i=1; s=lahtoruutu; d=iki.fi; t=1694621441; a=rsa-sha256;
        cv=none;
        b=s4PoMLoGk62KZiUKd/YqsItsm4YupnXaI7NFhl+vUlMUa8ga/yT26rJgLvMIrapJTdhEfp
        pT0OIoVBQ28YuDLbjemgcRloLzE7ih2uPOk1rd0BkhV2ASRC3c0f7r2CUABitC/HKULMAw
        ntMLR2LKDTAs/QeLeuKfdE/60MTAPqPGvHWadvwg4bGvvFI7cTN/k+/OUOoocqBugfLHKK
        lMD7awUFMpAb4T+iGUxUDHUUqqKgcopbPsP795nV3CoH2V36Qb/pKirAd3CtU5rjsb64qo
        H+dReamwjSZHL7KHG9w8TOhcw1y2n6lln1TxrGEvxE04ydqrmdNr11h13Ia4/g==
ARC-Authentication-Results: i=1;
        ORIGINATING;
        auth=pass smtp.auth=sailus smtp.mailfrom=sakari.ailus@iki.fi
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi;
        s=lahtoruutu; t=1694621441;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=R4tbkmHfyipimkB/hD8ONV34s4sKnuYw+dMzeFzQs0o=;
        b=p+oETlgl0r2Rv/YYyOWcLpZN+aYJtktkctUdnQntffp4esvxRYFHOH3sojnpxFLnf53ex8
        00olRHAC145IRrAx3eRLy3jsWEqVkvazWnmGWXgCWqPDDprHZmMZke0hMki6qgXpDQb7iw
        +1a5K0PulntKjy60YYisb8paI9q+HYBXc8ADz86oB7aa+ByJJIui4Jmuytzmtn1N+S4Wgs
        51fEG3uzKNf8IOXxi16vDjNmIuH8J33eyWCCp+RF4eFEP/DJRB97IKOobDsOpz4a17ZkuC
        c9AImZqDf9j3Tk6okJE/ow5D1646LPtm9DsJ4IQKRUN/3TwKlf+E4GW2DK3yyg==
Received: from valkosipuli.retiisi.eu (valkosipuli.localdomain [192.168.4.2])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by hillosipuli.retiisi.eu (Postfix) with ESMTPS id 94935634C93;
        Wed, 13 Sep 2023 19:10:40 +0300 (EEST)
Date:   Wed, 13 Sep 2023 16:10:40 +0000
From:   Sakari Ailus <sakari.ailus@iki.fi>
To:     Fabio Estevam <festevam@denx.de>
Cc:     robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        conor+dt@kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, mchehab@kernel.org,
        linux-media@vger.kernel.org,
        Conor Dooley <conor.dooley@microchip.com>
Subject: Re: [PATCH v3] dt-bindings: media: Add OV5642
Message-ID: <ZQHfAFWkYaEN7eKI@valkosipuli.retiisi.eu>
References: <20230802160326.293420-1-festevam@denx.de>
 <ZQHYAxAZxD1JMRHr@valkosipuli.retiisi.eu>
 <92aa6fe9e42fd80969846541ee14340c@denx.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <92aa6fe9e42fd80969846541ee14340c@denx.de>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Fabio,

On Wed, Sep 13, 2023 at 01:02:25PM -0300, Fabio Estevam wrote:
> Hi Sakari,
> 
> On 13/09/2023 12:40, Sakari Ailus wrote:
> 
> > You seem to have properties here that are specific to both parallel and
> > CSI-2 buses. Which one does the sensor use?
> 
> The OV5642 sensor can support both parallel and MIPI CSI-2 buses.

Then these properties should be conditional to that. Please see an example
in Documentation/devicetree/bindings/media/i2c/ovti,ov772x.yaml .

You can omit clock-lanes in any case as there's just a single one (0).

-- 
Regards,

Sakari Ailus
