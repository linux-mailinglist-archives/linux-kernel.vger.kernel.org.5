Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BB7667E5DA6
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Nov 2023 20:00:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232786AbjKHTAe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Nov 2023 14:00:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53148 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231420AbjKHTAV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Nov 2023 14:00:21 -0500
Received: from mail-oo1-f52.google.com (mail-oo1-f52.google.com [209.85.161.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 46BE22112;
        Wed,  8 Nov 2023 11:00:19 -0800 (PST)
Received: by mail-oo1-f52.google.com with SMTP id 006d021491bc7-5842a7fdc61so3638869eaf.3;
        Wed, 08 Nov 2023 11:00:19 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699470018; x=1700074818;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=p45+mKXA0+RLf0VAOhIL47ZOwEm+iVY06oIBhHYqI6I=;
        b=FmNjAKPev26JaZWfjR9IurRdrLIXWCh24Es6PzVfLxV9kOJhO8pCtKp0QeP0JXg6ku
         YapcpLdZY3V/lXTI6pNjCXIcYoWLESJHeW4pTE4prOX+0onHry5cdE9BkI20sNzqEw/D
         zIsdAEZ75WYAmCcTV3pBMVFP3QP6GAud2pIxBm3A/JzmILeehnonq3I8nQDNXcdaMRdm
         Wat3A7WRaEydcPqpLXTffDRpR7JM2VjgDyvJlJDNZWSF7t/7PyX2SfHOyY7NcF3C5wsl
         TB9n6g1IrD8oxOmkWBx+COQasB/+cYEaGzhWHaxS8yEd/lkdpC/vuJHiu7zNGJOBD9Da
         uaDg==
X-Gm-Message-State: AOJu0YwwX9t6JCBGv7gBfH9UnmeFqCyRUaHtnbzZrCxBDZwLFnjgfXyg
        z9m0CjXbl7yooNNcO9WB7A==
X-Google-Smtp-Source: AGHT+IEkYyb1Djykhk9kxaGlJRraar7VoY33K8knI8yAYqllxKdOZYsj5PzVppWGa3zReGgIqhfOrg==
X-Received: by 2002:a4a:a70c:0:b0:582:99ae:ca4c with SMTP id g12-20020a4aa70c000000b0058299aeca4cmr2672180oom.8.1699470018240;
        Wed, 08 Nov 2023 11:00:18 -0800 (PST)
Received: from herring.priv (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id z45-20020a4a9870000000b00587b9063e07sm1422833ooi.2.2023.11.08.11.00.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Nov 2023 11:00:17 -0800 (PST)
Received: (nullmailer pid 2754062 invoked by uid 1000);
        Wed, 08 Nov 2023 19:00:16 -0000
Date:   Wed, 8 Nov 2023 13:00:16 -0600
From:   Rob Herring <robh@kernel.org>
To:     Mehdi Djait <mehdi.djait@bootlin.com>
Cc:     linux-kernel@vger.kernel.org, paul.kocialkowski@bootlin.com,
        laurent.pinchart@ideasonboard.com, devicetree@vger.kernel.org,
        hverkuil-cisco@xs4all.nl, krzysztof.kozlowski+dt@linaro.org,
        maxime.chevallier@bootlin.com, mchehab@kernel.org,
        robh+dt@kernel.org, heiko@sntech.de, linux-media@vger.kernel.org,
        thomas.petazzoni@bootlin.com, conor+dt@kernel.org,
        alexandre.belloni@bootlin.com
Subject: Re: [PATCH v8 2/3] media: dt-bindings: media: i2c: Add bindings for
 TW9900
Message-ID: <169947001607.2754020.4176816227714592571.robh@kernel.org>
References: <cover.1699449537.git.mehdi.djait@bootlin.com>
 <0af5607f13b95e1312a1e8df516c8f3d6d0b20f0.1699449537.git.mehdi.djait@bootlin.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0af5607f13b95e1312a1e8df516c8f3d6d0b20f0.1699449537.git.mehdi.djait@bootlin.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Wed, 08 Nov 2023 14:27:13 +0100, Mehdi Djait wrote:
> The Techwell TW9900 is a video decoder supporting multiple input
> standards such as PAL and NTSC and has a parallel BT.656 output
> interface.
> 
> It's designed to be low-power, posesses some features such as a
> programmable comb-filter, and automatic input standard detection
> 
> Signed-off-by: Mehdi Djait <mehdi.djait@bootlin.com>
> ---
> V7->V8:
> - fixed the number of analog input ports: it is just one.
> - added endpoints of the analog input port
> - added vdd-supply to the required in the dt-binding documentation
> 
> V6->V7:
> - added powerdown-gpios and input ports
> - used 4 spaces for example identation
> 
> V5->V6:
> - This commit had a "Reviewed-by: Rob Herring <robh@kernel.org>" Tag but
>   decided not to collect it because the last Iteration was more than 2
>   years ago
> - removed SECAM from the mentioned standards
> - changed maintainer
> 
> V4->V5:
> - renamed the file to match the compatible string, and referenced
>   the graph.yaml schema
> 
> V3->V4:
> - add the missing reset-gpios node to the binding
> 
> V2->V3:
> - fix the example not compiling due to a typo in the reset-gpios
>   node.
> 
>  .../bindings/media/i2c/techwell,tw9900.yaml   | 137 ++++++++++++++++++
>  1 file changed, 137 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/media/i2c/techwell,tw9900.yaml
> 

Reviewed-by: Rob Herring <robh@kernel.org>

