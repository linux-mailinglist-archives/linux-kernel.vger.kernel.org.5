Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5D5A7754A35
	for <lists+linux-kernel@lfdr.de>; Sat, 15 Jul 2023 18:52:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230093AbjGOQw4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 15 Jul 2023 12:52:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52736 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229483AbjGOQwy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 15 Jul 2023 12:52:54 -0400
Received: from mail-pl1-x632.google.com (mail-pl1-x632.google.com [IPv6:2607:f8b0:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F35B5FD;
        Sat, 15 Jul 2023 09:52:53 -0700 (PDT)
Received: by mail-pl1-x632.google.com with SMTP id d9443c01a7336-1b9d80e33fbso18874155ad.0;
        Sat, 15 Jul 2023 09:52:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1689439973; x=1692031973;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=zklUF3t+wgeuuJ5wKVxFMVZbSHxpuwzj+yAFx67meI4=;
        b=UBkUcEL5Kch4QJK25VCJ/SbudlpqpohPaCDJsi3O/HCt7NHkaIxooPeezFlU4oy8PK
         BbkjK80uunSYUS6msSHliQx8w6paWmphpR6PV2zEd9zAdj6cDvvRtonGoXt3KUQLpaVg
         i1kM06AhZPilAFWuZ1HpssQ/fK4aHRCDWVV+yqriyV9RRUFimsO/menh3R8+F6JcA3wS
         v7gAaQsrESkVBIYAkjYWzEAxhZ7fpuprJyAo5F26+YpEsNI0IOMKRT4gCGXDFtQwP6KR
         TwtfUHLcks9WxAHCva+s8jtdVcL9+RA2Ywtk6j20QpJ/dYpsOjdbtw0Gbo1T3RzfszjN
         JSTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689439973; x=1692031973;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zklUF3t+wgeuuJ5wKVxFMVZbSHxpuwzj+yAFx67meI4=;
        b=W2JMzV7nNKZEH6Pj9hpwbFTKjm1xz+QWSvfejTuLSyitDAZDQTmYu4JCdfQmDKzGV6
         hsjOEIgF8tpFUECFY85JfeDX8WmxN/HRuOXPVZk1gd6DCCyLh6aGo0MsIMNCAuYj01eU
         4KJr+LvWLJST8Y78uDt7sZHRGk+dtOUHYFbn8c34Q/LGBQT4jm6f0x2bC6IOxLm19Kix
         wBtRt5C3JhTBzpF/LWNIc5EpHlPNkLxBZ5/RTXdKyO4dCBtOM5a/1EQCWukngiVD4Jre
         WcbthtmdEv2I5h/o0Hn8YxHy6HNB/EtFM9lD3uwZMh9SDxssJFXWKRMEHN8zUXgOrjQy
         VkLA==
X-Gm-Message-State: ABy/qLa/MQQuW18S02G8r4hY53dWO5wEmQrm0No31wbJqhIYEgbmY6Ll
        yg8+48syh3Wmo+sJnQbnL/ZznqDkcVU=
X-Google-Smtp-Source: APBJJlHwf5iQVqpPUZk9nG/eSQNHZuhoh+emme0qVcomwtnLtu6YobsTJ0CFwzxFT8v7LmNdd4A3uw==
X-Received: by 2002:a17:902:ea05:b0:1b8:9b17:f63d with SMTP id s5-20020a170902ea0500b001b89b17f63dmr8720295plg.23.1689439973371;
        Sat, 15 Jul 2023 09:52:53 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id ik25-20020a170902ab1900b001b54a88e4a6sm9898642plb.51.2023.07.15.09.52.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 15 Jul 2023 09:52:52 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Date:   Sat, 15 Jul 2023 09:52:52 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Cc:     Jean Delvare <jdelvare@suse.com>, linux-kernel@vger.kernel.org,
        kernel-janitors@vger.kernel.org, linux-hwmon@vger.kernel.org
Subject: Re: [PATCH] hwmon: lan966x: Use the devm_clk_get_enabled() helper
 function
Message-ID: <f4674073-d670-42cc-986d-cbee5d3afc40@roeck-us.net>
References: <25f2ab4c61d4fc48e8200f8754bb446f2b89ea89.1688795527.git.christophe.jaillet@wanadoo.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <25f2ab4c61d4fc48e8200f8754bb446f2b89ea89.1688795527.git.christophe.jaillet@wanadoo.fr>
X-Spam-Status: No, score=-1.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jul 08, 2023 at 07:52:31AM +0200, Christophe JAILLET wrote:
> Use the devm_clk_get_enabled() helper function instead of hand-writing it.
> It saves some line of codes.
> 
> Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>

Applied.

Thanks,
Guenter
