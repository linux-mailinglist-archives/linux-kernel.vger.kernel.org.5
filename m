Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 65DD777A70B
	for <lists+linux-kernel@lfdr.de>; Sun, 13 Aug 2023 16:48:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230029AbjHMOs3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 13 Aug 2023 10:48:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50522 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229441AbjHMOs2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 13 Aug 2023 10:48:28 -0400
Received: from mail-lf1-x135.google.com (mail-lf1-x135.google.com [IPv6:2a00:1450:4864:20::135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 687D11702
        for <linux-kernel@vger.kernel.org>; Sun, 13 Aug 2023 07:48:30 -0700 (PDT)
Received: by mail-lf1-x135.google.com with SMTP id 2adb3069b0e04-4fe4762173bso5634397e87.3
        for <linux-kernel@vger.kernel.org>; Sun, 13 Aug 2023 07:48:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1691938108; x=1692542908;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=187ilsO8HuDey2NBIRz6vfzKW5d6juB5N1HZU8xAdH0=;
        b=KqndpWeVatyQzoUq7yUXz+Dj3qBBUJ8zB85GIfMZORyV6s0kQj9sc2EUdCINwEKUtn
         jIvo6rm3YzbM1DpWXx5Go9NoKrv5hgEjZPWJZMuR+2buFsQyj7Wu6yma2zrZFFa6Oxno
         hJ7QgBdLxNYNBtvhfsUX98f0ywk9/Ap0jFiPY+6gG149nkG6I8d1xSoeZ1Mj+v8dCP3Y
         e/SHGoiOfRY7nrXrxhsMJnuKWDY89E2jIfISM9igZLjXnu9oQzw7QNXAwCsywTz2JtBi
         jOxhi5XvfajBWAGTOGnqPo1syv7ZwIog6SEbQ8MPqcBzDNUQCE2jcZb+lGmj2XObYqar
         0Q8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691938108; x=1692542908;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=187ilsO8HuDey2NBIRz6vfzKW5d6juB5N1HZU8xAdH0=;
        b=SHKhh5YJXg/mX2W6GBbKw00/bQlcBbNaFrkXR+ocjeksu9YFI1X3INkt6DcsEjoXYU
         TWY2b/1dF87/FkM03cYzzApQuX+cPRhk55FIEkM6JyUjJVYn2pRAJlK73PBywYNDJps7
         2EoNiIX4NsGYRl7Itr8zsRQI14n9ywn/OzCxG45c9IVXqpetOr1Muc0Z/DfHo2d4iNoL
         SFglhpxbHr2/Co9g/6fjHusJ2xV25k3obuarDnEGEHy8eAZl25wzvYH678RXCLEoGwAP
         GA9Dp5qexw26MdmDMlLYBDLvC7oLVeACE6aldX6jwqelIUkrrstNOJW9Q42Pjm5YYCpN
         hB7A==
X-Gm-Message-State: AOJu0Yx4p62ngEDaZUXrjylL0Ez+Sw37qQh8A5kkj15szf5CSbJWaaKq
        5yLbOT7Uvifs43kIg65dofM=
X-Google-Smtp-Source: AGHT+IFAbi3JCbVWWNlqjZ12qOrnWC7aa2xwJmRaI/CaTp3YRlYdLWnYw5tBAJjgAY+n8ER/KXmzGQ==
X-Received: by 2002:a05:6512:33d1:b0:4fb:7b4c:d38c with SMTP id d17-20020a05651233d100b004fb7b4cd38cmr5615923lfg.60.1691938108393;
        Sun, 13 Aug 2023 07:48:28 -0700 (PDT)
Received: from mobilestation ([109.194.233.135])
        by smtp.gmail.com with ESMTPSA id v13-20020ac2558d000000b004fdfefdf4acsm1532295lfg.39.2023.08.13.07.48.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 13 Aug 2023 07:48:27 -0700 (PDT)
Date:   Sun, 13 Aug 2023 17:48:25 +0300
From:   Serge Semin <fancer.lancer@gmail.com>
To:     Minjie Du <duminjie@vivo.com>
Cc:     Jon Mason <jdmason@kudzu.us>, Dave Jiang <dave.jiang@intel.com>,
        Allen Hubbe <allenbh@gmail.com>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        "open list:NTB DRIVER CORE" <ntb@lists.linux.dev>,
        open list <linux-kernel@vger.kernel.org>,
        opensource.kernel@vivo.com
Subject: Re: [PATCH v1] dtivers: ntb: fix parameter check in
 perf_setup_dbgfs()
Message-ID: <k7tdkycc2r4f4zjyzv3zdhufkt5lpeyyouptgf6pij4mpxi3yt@aulhd5he5ydm>
References: <20230713034728.2157-1-duminjie@vivo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230713034728.2157-1-duminjie@vivo.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 13, 2023 at 11:47:27AM +0800, Minjie Du wrote:
> Make IS_ERR() judge the debugfs_create_dir() function return
> in perf_setup_dbgfs().

The patch itself is correct for sure:
Reviewed-by: Serge Semin <fancer.lancer@gmail.com>

But as I already noted in a similar patch submitted for ntb_tool.c:
https://lore.kernel.org/ntb/5d0cd0e0-d92e-42d3-a6d9-ec9fc3229b7b@kadam.mountain/T/#m78d5823691d2f205d43aaa9e09028674d57296ab

Neither NTB perf, nor NTB tool, nor NTB pong-ping (nor likely NTB MSI
test) drivers make any sense without DebugFS because their
functionality has been developed based on the DebugFS nodes. The
better change would be to just fail the NTB devices probing in these
drivers if DebugFS is unsupported.

-Serge(y)

> 
> Signed-off-by: Minjie Du <duminjie@vivo.com>
> ---
>  drivers/ntb/test/ntb_perf.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/ntb/test/ntb_perf.c b/drivers/ntb/test/ntb_perf.c
> index 65e1e5cf1..553f1f46b 100644
> --- a/drivers/ntb/test/ntb_perf.c
> +++ b/drivers/ntb/test/ntb_perf.c
> @@ -1355,7 +1355,7 @@ static void perf_setup_dbgfs(struct perf_ctx *perf)
>  	struct pci_dev *pdev = perf->ntb->pdev;
>  
>  	perf->dbgfs_dir = debugfs_create_dir(pci_name(pdev), perf_dbgfs_topdir);
> -	if (!perf->dbgfs_dir) {
> +	if (IS_ERR(perf->dbgfs_dir)) {
>  		dev_warn(&perf->ntb->dev, "DebugFS unsupported\n");
>  		return;
>  	}
> -- 
> 2.39.0
> 
> 
