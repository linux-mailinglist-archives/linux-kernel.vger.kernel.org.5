Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D5E9479A0D8
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Sep 2023 02:48:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232038AbjIKAsk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 10 Sep 2023 20:48:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36614 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229493AbjIKAsj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 10 Sep 2023 20:48:39 -0400
Received: from mail-pf1-x436.google.com (mail-pf1-x436.google.com [IPv6:2607:f8b0:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D2D3132;
        Sun, 10 Sep 2023 17:48:35 -0700 (PDT)
Received: by mail-pf1-x436.google.com with SMTP id d2e1a72fcca58-68fbbea0dfeso295869b3a.0;
        Sun, 10 Sep 2023 17:48:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1694393315; x=1694998115; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=02J5wGaVmJGooXtgnvU3fjnoF9z/Wiv60ZFGiGdj2zg=;
        b=I72KeRdh0G3NZllVnNQ3s2t2llvy4uOps5WNI9fFi3ZdbirAzd1bq4mnBfQ9TVM//T
         P2m3GgCViLyBWpU2J9IAuI3mttCea7zjl4HEd/SdSOs+cPIev3s4ZDHLDuKwoKNOQigr
         wktMgScFrAoYSUgry+nQl1BQbmdAhAlmjNtOgAUS9H3CujSYn3OCIofDaSg8R6SLbxpR
         sS6i+wkn7NF65Os4zbFn7pJraqUosCrxN29PJBI0FpduVDuJP13WOTQ606HgZj8vgpj4
         k6s7OFulJyf26EUW6hmuQH5YcvY0eljuEzb4YVzUcRDigY/YG6ehnwMoqbYX2WdAjyUo
         wVzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694393315; x=1694998115;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=02J5wGaVmJGooXtgnvU3fjnoF9z/Wiv60ZFGiGdj2zg=;
        b=ellYMCSwHLr0nlBIkUGB6YrQtWWG2vnh1ywbu0Lx2CtQajNsa5I0lqQh8TsMZHeHWU
         dsv8oHEBlLdyoEbJP1+vqw0leEgoC1Dy6HDMNJxkIBm44Mwai8cOwgVNXAUQQvHt43vF
         QihfMkJBw+vbQIhvPcPbxJmEqwT76XR9A0pafnW8jqnGoVAZ4qvrYMWSWEIs2inCoDDD
         4VSmfNVYm3jCIn/TpVrR0/RFq+p4fmDs4c/aIRc6FzTCI9rwTwzpNIpRYij2xl8EjHlr
         2SnOfPrnRAfdojYweqnDwF9+8AeyCpDbLyWqdYzt8JmiRqlzTDLWhbFS14WtTYe2e4RA
         TdWg==
X-Gm-Message-State: AOJu0YwjylaCU/AzhuwAM2/U3vJGCQYN0aEBhGCtgISlVHMouGVulzKH
        rC/vvdVe/DlsoLljurxesys=
X-Google-Smtp-Source: AGHT+IGq4VJoNyMd7UKX5oNyejXncH7vr/Fb4lknO9aGj+/unHuFAPXCfIKgB4yWWNqi2DBh5+Wlag==
X-Received: by 2002:a05:6a20:e125:b0:152:3e16:3f0b with SMTP id kr37-20020a056a20e12500b001523e163f0bmr8962534pzb.46.1694393314668;
        Sun, 10 Sep 2023 17:48:34 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id j10-20020aa7800a000000b0066f37665a63sm4393270pfi.73.2023.09.10.17.48.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 10 Sep 2023 17:48:34 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Date:   Sun, 10 Sep 2023 17:48:33 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     Armin Wolf <W_Armin@gmx.de>
Cc:     hdegoede@redhat.com, jdelvare@suse.com,
        linux-hwmon@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/5] hwmon: (sch5627) Use bit macros when accessing
 the control register
Message-ID: <c8238cd2-00a1-43a5-8b6b-871cba0da4d0@roeck-us.net>
References: <20230907052639.16491-1-W_Armin@gmx.de>
 <20230907052639.16491-2-W_Armin@gmx.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230907052639.16491-2-W_Armin@gmx.de>
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 07, 2023 at 07:26:35AM +0200, Armin Wolf wrote:
> Use bit macros then accessing SCH5627_REG_CTRL, so that people
> do not need to look at the datasheet to find out what each bit
> does.
> 
> Tested on a Fujitsu Esprimo P720.
> 
> Signed-off-by: Armin Wolf <W_Armin@gmx.de>

Applied.

Thanks,
Guenter
