Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5CBEE7CD83E
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Oct 2023 11:34:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229870AbjJRJev (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Oct 2023 05:34:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35312 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230169AbjJRJen (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Oct 2023 05:34:43 -0400
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com [IPv6:2a00:1450:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5F75D113
        for <linux-kernel@vger.kernel.org>; Wed, 18 Oct 2023 02:34:41 -0700 (PDT)
Received: by mail-wr1-x429.google.com with SMTP id ffacd0b85a97d-317c3ac7339so5742306f8f.0
        for <linux-kernel@vger.kernel.org>; Wed, 18 Oct 2023 02:34:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1697621679; x=1698226479; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=2sv0FCDZpFwcd+OomNX8xlBQ0tLiUtxgv2CzVm71AOM=;
        b=P2Sa+JPxtt9/d4lV9U0Ml4S8z4OIH6TxLXid5B1elUI2nW4LBi9/zuhyyEIleg704+
         ozb5+2TCnA0b7bxa+WD6t/705GL3Q7Q/utlAB0K0QctcI4TWstm7Vih3/nRMio4QwcPt
         9x4vjmrG6xHGKsRwaoWuPcjNKqIjnEvCjwAgKEng96zXjx8Ieuvz9wuzwAXq/BHZwp/K
         EHNFv3ozEMWK5APRQaKHpow/iw2RGokMD1YjhU5d2Mxo+5kUFyJ60W4wFpVs3KnDOd01
         PsjNJacEL6N8QFDdE0pdS6+E9Kzeh/13RNwp22RPACKCqd7PIkynBhW+FtBxCV9HYXga
         f9zg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697621679; x=1698226479;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2sv0FCDZpFwcd+OomNX8xlBQ0tLiUtxgv2CzVm71AOM=;
        b=gveoz625528SrJuyg7AK1IVpwLPNYkOUpJPFT4Amf9yuICE9ERSA7m35CMU7yJTc+q
         vVWw4IkdKZXqBwX8Vsygwr0GboZiMFQZJJ43K2bDFekzvWQTEmU5Slm43VXK1MxavixL
         za4FX/r3M0wxZWLGmkgmQKEY8TN1IJsdsDniJubx7ccBac5s280IL9/VA3WZSjK2UIv/
         2BXkBysFB1DFLJtywWLnp159BBYCxwfv9SdZHcXM4qwLtla+560ra9W4GbSmdx/tWIql
         ppFLqwlQLQHd1ZW5hIo5ordANUdDNzJPIrsOB9ihfMWdIXOCV/kFjiQVW3phSTWTD4c9
         Ij9Q==
X-Gm-Message-State: AOJu0YzYuUJFBvl/p5G0hv+rtZoOW0IGrLe7lBJyvJokHfeJgrqNdpJh
        IzFwhRh8MuYm0H3E8SAwdFKkHQ==
X-Google-Smtp-Source: AGHT+IGIAS/j+uj93RmHmX/KEbmsiZXmJCczP64fq3Xd7hK0t1HHw4THzR0C0AbDNLPG9A9j4rAoxw==
X-Received: by 2002:a5d:4f02:0:b0:32d:a28b:da08 with SMTP id c2-20020a5d4f02000000b0032da28bda08mr3721637wru.62.1697621679570;
        Wed, 18 Oct 2023 02:34:39 -0700 (PDT)
Received: from localhost ([102.36.222.112])
        by smtp.gmail.com with ESMTPSA id h13-20020a056000000d00b0031fd849e797sm1681945wrx.105.2023.10.18.02.34.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Oct 2023 02:34:39 -0700 (PDT)
Date:   Wed, 18 Oct 2023 12:34:36 +0300
From:   Dan Carpenter <dan.carpenter@linaro.org>
To:     Dorcas AnonoLitunya <anonolitunya@gmail.com>
Cc:     outreachy@lists.linux.dev, julia.lawall@inria.fr,
        andi.shyti@linux.intel.com,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Sudip Mukherjee <sudipm.mukherjee@gmail.com>,
        Teddy Wang <teddy.wang@siliconmotion.com>,
        linux-fbdev@vger.kernel.org, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] staging: sm750fb: Remove unused return value in
 program_mode_registers()
Message-ID: <41a6ac1b-d21e-41ab-b193-623d2f5f2d2c@kadam.mountain>
References: <cover.1697619623.git.anonolitunya@gmail.com>
 <492e63bbc58147fb534930ef9e1fb5d844ae8769.1697619623.git.anonolitunya@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <492e63bbc58147fb534930ef9e1fb5d844ae8769.1697619623.git.anonolitunya@gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 18, 2023 at 12:07:38PM +0300, Dorcas AnonoLitunya wrote:
> -static int program_mode_registers(struct mode_parameter *mode_param,
> -				  struct pll_value *pll)
> +static void program_mode_registers(struct mode_parameter *mode_param,
> +				   struct pll_value *pll)
>  {
>  	int ret = 0;
>  	int cnt = 0;
> @@ -202,7 +202,6 @@ static int program_mode_registers(struct mode_parameter *mode_param,
>  	} else {
>  		ret = -1;

No need to set ret here.

>  	}
> -	return ret;
>  }

regards,
dan carpenter

