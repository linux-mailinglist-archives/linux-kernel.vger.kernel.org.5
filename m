Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5EBA67E9EFB
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Nov 2023 15:43:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230242AbjKMOnw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Nov 2023 09:43:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43870 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229612AbjKMOnv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Nov 2023 09:43:51 -0500
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com [IPv6:2a00:1450:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 82406172B
        for <linux-kernel@vger.kernel.org>; Mon, 13 Nov 2023 06:43:47 -0800 (PST)
Received: by mail-wr1-x432.google.com with SMTP id ffacd0b85a97d-32f7c80ab33so2678362f8f.0
        for <linux-kernel@vger.kernel.org>; Mon, 13 Nov 2023 06:43:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1699886626; x=1700491426; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=vNnR04yCNnmtJJPXHpBhPgt3OU1li3/fE3RG16gZ0bU=;
        b=yxQftqbAw6f0QHBpxR9ncZPjYcUuB/yZ0qjBNAWI9dd7SAW0WjjHlKB9t8sgxQIzPC
         qKXmxyfhluWP7e7mb02V56lj7K5eYUggNq/yyJO5Pydb5cj8TLPY1nlcklgy5/Z1Uyxg
         3nVsWaZ5KdvgN5ddXnMXNJ5AwJglb8s6hMuPFA7Xmxqyc+vWU0huwNiLDMAfCdrVcSgp
         Ax6RlOabzW3O+zdhvEGeajQ9yAnkpnvEY6Ji7E2GUug0Rr10kSk8JKAM+BTFeSUaK5k4
         xN239d8M8v6Roh4oDIEoUr07M0/MJywrGW/zkNWJhAuwelkUn4I18IwqoXeRHTT1gjb5
         Xclw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699886626; x=1700491426;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vNnR04yCNnmtJJPXHpBhPgt3OU1li3/fE3RG16gZ0bU=;
        b=T2JtHH3q4Erzdgj8pC2y60tncPsBkKShYsGIssYJBwTmqWcF03DBp3IQRCw6qOPPB7
         aICs83laSAAPnwUrqEytlrnmZjeciwTkjtMtccJDonc8PylwBK2QsjiHSbqAjBFNgP8Q
         FX+M27IXsYgPaxyFQMdB+AzI4+0tk+k4grP2V1NSd3MoUN83SO9CkxTJ9ewo3sZDM+BI
         8p9EWTqqv/aBuROhWLCv4I28vvSNdstfAEz8C+bMa1liaHWO4xxCiKhIZJwYPdtN9K0L
         I2jswnELLU+Xsxs7CrelycM786LMGPtWvFFw+s6DEz7iIolxVFbulg41FmggHmzVrwS2
         HwbQ==
X-Gm-Message-State: AOJu0Yw4MqV7pxOrV30eACnVlTM+Gbkuxjf5dZF0PFaVaXmaEj7BQPSc
        JXJoSvjcV/dTe4kLmtZ8hfR7cw==
X-Google-Smtp-Source: AGHT+IFyl4KKFJvEAx90PJK12JnmMzqY/5jHnJCgMk1zVzPkN1C68bLXevTx5IpixEgyODWdzc7+bg==
X-Received: by 2002:adf:a3da:0:b0:32f:7db1:22fb with SMTP id m26-20020adfa3da000000b0032f7db122fbmr4253284wrb.28.1699886625790;
        Mon, 13 Nov 2023 06:43:45 -0800 (PST)
Received: from aspen.lan (aztw-34-b2-v4wan-166919-cust780.vm26.cable.virginm.net. [82.37.195.13])
        by smtp.gmail.com with ESMTPSA id b11-20020a05600010cb00b0032f9688ea48sm5574339wrx.10.2023.11.13.06.43.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Nov 2023 06:43:45 -0800 (PST)
Date:   Mon, 13 Nov 2023 14:43:43 +0000
From:   Daniel Thompson <daniel.thompson@linaro.org>
To:     Flavio Suligoi <f.suligoi@asem.it>
Cc:     Lee Jones <lee@kernel.org>, Jingoo Han <jingoohan1@gmail.com>,
        Helge Deller <deller@gmx.de>, Pavel Machek <pavel@ucw.cz>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        dri-devel@lists.freedesktop.org, linux-leds@vger.kernel.org,
        devicetree@vger.kernel.org, linux-fbdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/1] dt-bindings: backlight: mp3309c: remove two
 required properties
Message-ID: <20231113144343.GA264383@aspen.lan>
References: <20231025155057.886823-1-f.suligoi@asem.it>
 <20231025155057.886823-2-f.suligoi@asem.it>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231025155057.886823-2-f.suligoi@asem.it>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 25, 2023 at 05:50:57PM +0200, Flavio Suligoi wrote:
> NOTE: there are no compatibility problems with the previous version,
>       since the device driver has not yet been included in any kernel.
>       Only this dt-binding yaml file is already included in the
>       "for-backlight-next" branch of the "backlight" kernel repository.
>       No developer may have used it.

I'm afraid I got confused by the fragmented MP3309C patches from all the
different patchsets.

Please can you rebase whatever is left on v6.7-rc1 and send a single
patchset with all pending changes as a single patch set.


Thanks

Daniel.
