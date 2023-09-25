Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7607F7AD993
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Sep 2023 15:51:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232068AbjIYNvi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Sep 2023 09:51:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39740 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232186AbjIYNve (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Sep 2023 09:51:34 -0400
Received: from mail-pf1-x434.google.com (mail-pf1-x434.google.com [IPv6:2607:f8b0:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3CD3A127;
        Mon, 25 Sep 2023 06:51:26 -0700 (PDT)
Received: by mail-pf1-x434.google.com with SMTP id d2e1a72fcca58-690d8fb3b7eso5753300b3a.1;
        Mon, 25 Sep 2023 06:51:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1695649885; x=1696254685; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=O9GBKjbuWXOEQRKAYL5Wz7n1gs5mlhI+vmsYEwl9OBc=;
        b=IrI7qwyE4aaA6rtUiEuEap7xxaMdC5kpO0jeBd/e8kSIPTipZm/Zsl3RTzHqS38Pv1
         K/Gk/aKysBwfJrbk4CrTW2/Ksd8uQXQCnRrUsTAfuIOsqX4MEOdullGZwedZPO4/ReE6
         RLCJGhRDmXwLYUDU2iXVsozSDDlYUPdnybbbRkgh0o8xyrdwF9juoNb8/5/So82OfzB9
         0tTxM7U7yaRnot8Unfyf5fp3k9Xq5kfhiR7rEs0QgTs5XpGXY5MjDe/Ue+ojex4TQZqW
         vnrjBsWqKytFnji3nJGPUza3ZNW1eY3TXfHx1qxr/mV9kx4jBA7Pg+saHLuDQdhkv2G9
         7zog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695649885; x=1696254685;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=O9GBKjbuWXOEQRKAYL5Wz7n1gs5mlhI+vmsYEwl9OBc=;
        b=H36ZmMpydaFk4/iVTiClbIlVLg1lb9SrkyDNVH26oyF2l7oSeDnCgd/D///aCWn398
         trkyDmCU3eZQ1CSu2gs9q8LxKX0ZBrwXt9pWxt2SVTexF25a3M4bHBddtKP1UegMK4E6
         n2f+afkavEqGNCLlygS/mv6EnT1nRAo5RBgWt7BGJwiCuHK6zCg5N0S+paSEoj94tc4V
         Sy9Jl/vz5kvHWQ8P090bCdqNNszE+iAhBeS9MLOd0KmO1+FT643aAiEjicv0KRXUnIG7
         KW9oxzKNfvDa/YWEsovbAxxdIIg9eRVuoUWjL+AklA57ZrnHqTdiOhXpGS5nkNGN20Kh
         DDwg==
X-Gm-Message-State: AOJu0Ywptzmw1m5ZgYj4EGmmMmEOwOKtGisJn3oY19m13KjapGtVvDTn
        0CJqbkyPDSJgoEjQQ2dw/UA=
X-Google-Smtp-Source: AGHT+IHCDA/oXlTq+qCxhgPssCVAqWd0GIbXtvDfL+UXbcRW9SAWgxTKhn7C0HmWoeHq0ObKJgOK5Q==
X-Received: by 2002:a05:6a21:819d:b0:11d:4c79:90ee with SMTP id pd29-20020a056a21819d00b0011d4c7990eemr6442358pzb.25.1695649885542;
        Mon, 25 Sep 2023 06:51:25 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id lt23-20020a17090b355700b00276a4e67659sm9857800pjb.43.2023.09.25.06.51.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Sep 2023 06:51:24 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Date:   Mon, 25 Sep 2023 06:51:23 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     Manjunatha Venkatesh <manjunatha.venkatesh@nxp.com>,
        linux-kernel@vger.kernel.org, will@kernel.org, axboe@kernel.dk,
        robh+dt@kernel.org, mb@lightnvm.io, ckeepax@opensource.cirrus.com,
        arnd@arndb.d, mst@redhat.com, javier@javigon.com,
        mikelley@microsoft.com, jasowang@redhat.com,
        sunilmut@microsoft.com, bjorn.andersson@linaro.org,
        krzysztof.kozlowski+dt@linaro.org, devicetree@vger.kernel.org,
        ashish.deshpande@nxp.com, rvmanjumce@gmail.com,
        Kwame Adwere <kwame.adwere@nxp.com>
Subject: Re: [PATCH v6 2/2] misc: nxp-sr1xx: UWB driver support for sr1xx
 series chip
Message-ID: <c71c3d61-f6a4-44c4-812b-5abb0eb5edcb@roeck-us.net>
References: <20221220154747.2372597-1-manjunatha.venkatesh@nxp.com>
 <20221220154747.2372597-3-manjunatha.venkatesh@nxp.com>
 <Y6Kj4VlnJFFrzYW9@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y6Kj4VlnJFFrzYW9@kroah.com>
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

On Wed, Dec 21, 2022 at 07:12:49AM +0100, Greg KH wrote:
> On Tue, Dec 20, 2022 at 09:17:47PM +0530, Manjunatha Venkatesh wrote:
> > Ultra-wideband (UWB) is a short-range wireless communication protocol.
> > 
> > NXP has SR1XX family of UWB Subsystems (UWBS) devices. SR1XX SOCs
> > are FiRa Compliant. SR1XX SOCs are flash less devices and they need
> > Firmware Download on every device boot. More details on the SR1XX Family
> > can be found at https://www.nxp.com/products/:UWB-TRIMENSION
> > 
> > The sr1xx driver work the SR1XX Family of UWBS, and uses UWB Controller
> > Interface (UCI).  The corresponding details are available in the FiRa
> > Consortium Website (https://www.firaconsortium.org/).
> > 
> > Internally driver will handle two modes of operation.
> > 1.HBCI mode (sr1xx BootROM Code Interface)
> >   Firmware download uses HBCI ptotocol packet structure which is
> >   Nxp proprietary,Firmware File(.bin) stored in user space context
> >   and during device init sequence pick the firmware packet in chunk
> >   and send it to the driver with write() api call.
> > 
> >   After the firmware download sequence at the end UWBS will
> >   send device status notification and its indication of device entered
> >   UCI mode.
> >   Here after any command/response/notification will follow
> >   UCI packet structure.
> > 
> > 2.UCI mode (UWB Command interface)
> >   Once Firmware download finishes sr1xx will switch to UCI mode.
> >   Then driver exchange command/response/notification as per the FIRA UCI
> >   standard format between user space and sr1xx device.
> >   Any response or notification received from sr1xx through SPI line
> >   will convey to user space.
> > 
> >   Its Interrupt based driver and IO Handshake needed with SR1XX Family of
> >   SOCs.
> >   This driver needs dts config update as per the sr1xx data sheet.
> >   Corresponding document available in Documentation/devicetree/bindings/uwb
> > 
[ ... ]
> 
> Also, I see no justification here for why this has to be a kernel
> driver, OR where the userspace code is that controls this.
> 

After seeing all the warnings generated by 0-day after this driver was
applied to chromeos-6.1, my basic question is similar but boils down to:
Why does this need a userspace component to start with, and why wasn't it
implemented as firmware download driver ?

Guenter
