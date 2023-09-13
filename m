Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6C20779EDE2
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Sep 2023 18:02:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230309AbjIMQCc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Sep 2023 12:02:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52518 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230000AbjIMQCb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Sep 2023 12:02:31 -0400
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9361195;
        Wed, 13 Sep 2023 09:02:27 -0700 (PDT)
Received: from mail.denx.de (unknown [IPv6:2a01:238:438b:c500:173d:9f52:ddab:ee01])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: festevam@denx.de)
        by phobos.denx.de (Postfix) with ESMTPSA id 97C2986785;
        Wed, 13 Sep 2023 18:02:25 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
        s=phobos-20191101; t=1694620945;
        bh=cyVL8KSK7rxvD0HuVra13JDhO6XQnmGNj04iH7x8UMY=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=xb3pG3Jyqf/nnk2xXiA66jtMCK+reCyNvS4C27aHewFb8xc9kGsezVMAgTMsAj1Xb
         PeBP/5VQJ5IIHr41xYm209C03AdgAUkJbS8imJwZ7s15mqKvKEGJMxaECT/qlswAdO
         TxLIyzYK6wDV7D5B9xA1IqE5EZLOj8W9wPkrqNJqznGWREelhU5uX6DovXmSjWqO7y
         2nGtbYgAlUJEe3QcP2Xu6DgphJ/zS/6VCPnA37isE+BOiS4muv9ov0ExO+X8e7iWon
         ebIpLa6hHs0SCvPiIj7/6UsPy1IxKcjNCKfRh6pW7x8LxyxNKkb0sRxvbmg8K4Tj0l
         CrWrUanlMGaRA==
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Wed, 13 Sep 2023 13:02:25 -0300
From:   Fabio Estevam <festevam@denx.de>
To:     Sakari Ailus <sakari.ailus@iki.fi>
Cc:     robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        conor+dt@kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, mchehab@kernel.org,
        linux-media@vger.kernel.org,
        Conor Dooley <conor.dooley@microchip.com>
Subject: Re: [PATCH v3] dt-bindings: media: Add OV5642
In-Reply-To: <ZQHYAxAZxD1JMRHr@valkosipuli.retiisi.eu>
References: <20230802160326.293420-1-festevam@denx.de>
 <ZQHYAxAZxD1JMRHr@valkosipuli.retiisi.eu>
Message-ID: <92aa6fe9e42fd80969846541ee14340c@denx.de>
X-Sender: festevam@denx.de
User-Agent: Roundcube Webmail/1.3.6
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Sakari,

On 13/09/2023 12:40, Sakari Ailus wrote:

> You seem to have properties here that are specific to both parallel and
> CSI-2 buses. Which one does the sensor use?

The OV5642 sensor can support both parallel and MIPI CSI-2 buses.
