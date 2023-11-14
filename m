Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 10DBE7EA96C
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Nov 2023 05:16:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232034AbjKNEP7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Nov 2023 23:15:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58022 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231970AbjKNEP4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Nov 2023 23:15:56 -0500
Received: from mail-pj1-x102b.google.com (mail-pj1-x102b.google.com [IPv6:2607:f8b0:4864:20::102b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DF84ED0;
        Mon, 13 Nov 2023 20:15:51 -0800 (PST)
Received: by mail-pj1-x102b.google.com with SMTP id 98e67ed59e1d1-28099d11c49so1092883a91.1;
        Mon, 13 Nov 2023 20:15:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1699935351; x=1700540151; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=RE6VvMtBCo/S66AHg+l/y7o7DeXG142T7fh8adrCVRU=;
        b=VY0EXT9DhjkwauQy4GuJoboDuFUFFod56LKCa6cRqA2z4wtySGsE8HrBrbkBw2XRyd
         VAN8Lou6sLBEmYdU/sZgi2+JK2HXeATDyA0NtIoKZU+YcuCJx6NFKFxbImZR/g1ee4Hb
         wol278qI7bylw6Dz96+LyzPJoiFSA+IjIzMpjO8KZZnmmgj0zXFXHa6KMsueLxIbe0So
         NMIAF1fq4k0c+vnVjYM6GGiIBhZjQZBKICl9zVVsWYlTBdHaA5FHBCa30xsXOLJFbKCe
         xkqKZeBVA/LIqsNOaNA4++aKSaaI1z+qXjrZPdSP10XdzHUX2nHICwSSZBNBCjM34np9
         ZxUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699935351; x=1700540151;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RE6VvMtBCo/S66AHg+l/y7o7DeXG142T7fh8adrCVRU=;
        b=d5Uy486kzzVp65MrWUhP2YhPkQ4mI7VklYPiZY1W35M+J63lnyIA61tZRANeeYP04X
         JIMSQ/9MLkJLYiFUq55JlxZdMoNhGqCyIZGSyZctCmov244w0QVJy+DuGg5d/dusI/Ez
         bCAiwCiY0VoyVPwTYOQqo5UILg4fxwwPoZHD9IqnA/z1E7jSRalS23zz5uobqzHtXyKN
         8UiPf/CnEhuFqbxu7nGIao5mRSogb2Xsxuw+ta/s6Txna7l97+CIsDuS8YOqZrwAHI3I
         Il4OzOXcLbljk4yjeUBr7Kl6VFIMiMhyVz0JSRG0PAOcBvp0xp9mL7Y8nlElu66BNXC4
         vDWw==
X-Gm-Message-State: AOJu0Yy2v39PNG2PFL1heffjiH7kvGqZZvA09czGd1GHO8OAkhGaRTL4
        3KiywKoFHGG+aHPmcma0rli7DJkLmaM=
X-Google-Smtp-Source: AGHT+IGD0DYTC/XhPUxLNhCWa3XebHSt7NuxtQDxk3WZdWqhVNDlNiQL9U5WCkhJfeGD+iGDRsjI/A==
X-Received: by 2002:a17:90b:e13:b0:27f:f8d6:9622 with SMTP id ge19-20020a17090b0e1300b0027ff8d69622mr1021370pjb.0.1699935351275;
        Mon, 13 Nov 2023 20:15:51 -0800 (PST)
Received: from hoboy.vegasvil.org ([2601:640:8000:54:e2d5:5eff:fea5:802f])
        by smtp.gmail.com with ESMTPSA id c3-20020a17090ad90300b002805740d668sm6324359pjv.4.2023.11.13.20.15.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Nov 2023 20:15:50 -0800 (PST)
Date:   Mon, 13 Nov 2023 20:15:48 -0800
From:   Richard Cochran <richardcochran@gmail.com>
To:     Jacob Keller <jacob.e.keller@intel.com>
Cc:     Min Li <lnimi@hotmail.com>, linux-kernel@vger.kernel.org,
        netdev@vger.kernel.org, Min Li <min.li.xe@renesas.com>
Subject: Re: [PATCH net-next RFC 1/1] ptp: use extts interface for the
 measured external offset
Message-ID: <ZVL0dIpwCE94ylfH@hoboy.vegasvil.org>
References: <MW5PR03MB6932F6DB45F5ED179DF0BA4DA0B3A@MW5PR03MB6932.namprd03.prod.outlook.com>
 <490abfce-47b6-430c-8fc1-99536284c1a6@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <490abfce-47b6-430c-8fc1-99536284c1a6@intel.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 13, 2023 at 03:00:15PM -0800, Jacob Keller wrote:
> You mention GNSS, but is there an example or a link to a driver change
> you could provide to show its use?

Yes, the new option must wait for a driver that implements it.  Can
you make a patch series where the driver change appears in the second
patch?

Thanks,
Richard
