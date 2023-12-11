Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 98B3180CE3D
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Dec 2023 15:21:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344604AbjLKOVr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Dec 2023 09:21:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40228 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344643AbjLKOV1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Dec 2023 09:21:27 -0500
Received: from mail-pf1-x433.google.com (mail-pf1-x433.google.com [IPv6:2607:f8b0:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E05F61A6;
        Mon, 11 Dec 2023 06:19:47 -0800 (PST)
Received: by mail-pf1-x433.google.com with SMTP id d2e1a72fcca58-6cea1522303so2760137b3a.1;
        Mon, 11 Dec 2023 06:19:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1702304387; x=1702909187; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=r58Hx+bpOASpFCplSCGV1AunCLH29Sxl95drZqVDBCA=;
        b=ht57VIPqWfCEU18EwYPkFJCyuQqrxaoN6paUzC6BVLuFWuDMAxs+ITVfUtVwO4ZlTa
         6F3rjGHeHZZLZs3m9qAGGTbIrKdNltxMjN6U8KImdqoWHN8vw2xZrbuEO/YmolrGVi/8
         ahcKX5xJ89OrORX5nEggwMZfwYe26FGiDLM+vwR/SOKoVJzL7Axcso6smWIhuTcTQbkk
         SLHHx4kXC6McDuIph2ZvvO0ZQhVRW8hAeZHQu/SVh/WJypaRtP5jMN7fmcmaGnFGyQUp
         eryAaoCl6/nSj7OnTdHPhh+BDmFRuppIXEWhzAAKVY0SQ9xXELWIbpbrLtYS2ZwfNMS4
         n6Zw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702304387; x=1702909187;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=r58Hx+bpOASpFCplSCGV1AunCLH29Sxl95drZqVDBCA=;
        b=Kf5h1gib0+eQWm0ZZ4rpG/JEmCsAe2XiBX4N4F+fDV08Zd+4MvLjmwGoZGnonKuqEh
         rXEMDpSyWB/HTyuEnDM7QuJiTEIiksXB8jop4JVvPhJ3+oNPTGJlo4cYfTwKW5pvjZfD
         ERedXTE7Q8MA833yj0HhcFTF2dkIO659Z3ykqDGQNeYaqx0YcMlcNHimLEOIO/IsQWLU
         GWrAGHeZ8orqBqAFOsmv0MPmkMkDE8xTThc2ccn5eNw98Mq9sh6gXNcQ2sISZHp59ZL+
         molRyrUMQ+Q9bocnt9/aeqLsYPpxwP4wtjvLf0kH71UIJ1R2JzeoR4Qm/StUGbHd2IyS
         7A9A==
X-Gm-Message-State: AOJu0Yy0ghI1hP5pW39+zf+97IDmAYP2DLudwGWr6R6vjtoOjFEPugDI
        zX+cuQpNCHw9LPRFhu7BEtM=
X-Google-Smtp-Source: AGHT+IFaG2xy58uua8UiYgi/Z8VZhSpu2bZnwkCo8IfgfLr8e/tguRpyfSRn9AhgW8pcpZoUALlCXQ==
X-Received: by 2002:a05:6a00:238f:b0:6ce:2731:5f67 with SMTP id f15-20020a056a00238f00b006ce27315f67mr2385909pfc.38.1702304387274;
        Mon, 11 Dec 2023 06:19:47 -0800 (PST)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id t2-20020a62d142000000b006ce69a70254sm6603221pfl.56.2023.12.11.06.19.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Dec 2023 06:19:46 -0800 (PST)
Sender: Guenter Roeck <groeck7@gmail.com>
Date:   Mon, 11 Dec 2023 06:19:46 -0800
From:   Guenter Roeck <linux@roeck-us.net>
To:     Delphine CC Chiu <Delphine_CC_Chiu@wiwynn.com>
Cc:     patrick@stwcx.xyz, Jean Delvare <jdelvare@suse.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>, linux-i2c@vger.kernel.org,
        linux-hwmon@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org
Subject: Re: [PATCH v7 2/2] hwmon: pmbus: Add ltc4286 driver
Message-ID: <3ae58a01-4794-4ad2-bc1b-61f1cf2e467c@roeck-us.net>
References: <20231123015440.199822-1-Delphine_CC_Chiu@Wiwynn.com>
 <20231123015440.199822-3-Delphine_CC_Chiu@Wiwynn.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231123015440.199822-3-Delphine_CC_Chiu@Wiwynn.com>
X-Spam-Status: No, score=-0.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_XBL,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 23, 2023 at 09:54:37AM +0800, Delphine CC Chiu wrote:
> Add a driver to support ltc4286 chip
> 
> Signed-off-by: Delphine CC Chiu <Delphine_CC_Chiu@Wiwynn.com>

Applied, after fixing checkpatch message.

Guenter
