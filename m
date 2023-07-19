Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9BE12758BD1
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Jul 2023 05:08:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230285AbjGSDH4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Jul 2023 23:07:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41638 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229495AbjGSDHx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Jul 2023 23:07:53 -0400
Received: from mail-pg1-x532.google.com (mail-pg1-x532.google.com [IPv6:2607:f8b0:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 89DA11BDC;
        Tue, 18 Jul 2023 20:07:52 -0700 (PDT)
Received: by mail-pg1-x532.google.com with SMTP id 41be03b00d2f7-55b1238a013so4913383a12.3;
        Tue, 18 Jul 2023 20:07:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1689736072; x=1692328072;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=WFE8vQN8EwQOZwCatIjB/twUGRI06Jr11e01KPcsW9w=;
        b=TQFwmJ4R9HTIMNNnDFiw+XOTZ7Hi+XYBAgvMKcKiRRmgf9mEEd9gs0M+T+fnBytlvd
         CS91obCUXhzK42bBGQ15dcOMVGwA+xWmMa6yBIiD7XO3urhCq1P36hEbnc1JRLf+63Dw
         TgxHEoVFsCjkS88pBVoQLxCS4NKV4Lu+ks7OS0p1zJYrMIRxg+uZtJK+a02wIXSnyB4Z
         VPBUVvr+8YmLdbAQAcbrB24Qb5D+wpy+bV7QdGwXXta9pXRXFJ4Q9GIoobO4i37SFawe
         95CIup06fqrF3CVgwgpK+GUDtwGeXDQIYP3NV4+VxA5ALlv+fylAqp4A4rYMVlXUrpWc
         kU8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689736072; x=1692328072;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=WFE8vQN8EwQOZwCatIjB/twUGRI06Jr11e01KPcsW9w=;
        b=FDSFcpothLsJp55jRjxy4YAgjFaJ3BLSChky5Hr5Uk2SUfv8uBNgm/dt4CVjRcOOS1
         p9t8h2mpyNA/HMJvaGjJAGGdNjbxCSmL/ejhKWRn7pEs2jEpyjAr1qTzSvXJ/+S02og2
         u5+qi5bj65P7V3AiP+1I89PDbzVbC+/i4mjxiExKnh19P+ljqZP3n5E0srs1LH1WlbNZ
         2tkItKUkhmoaOOGu8IYfLTrdN/rBesS1q/QFWh4vkRafwBw0Ai0uN3QekGkTwhZeBBeV
         8tJC4vM5PAcfhwdSEYmZ3qemmRUGFfk55EIskpuzeMsoSS3dRNClPVRSdy3mKgAXI520
         TNXw==
X-Gm-Message-State: ABy/qLa7nPHDUT5D/6Lv8m0OGrv23sQCXBBfUWuOBK16C/u+kTcRALzz
        ZAfIBMeL9hompTP4LWi6g98=
X-Google-Smtp-Source: APBJJlGHlZYToOsYLlSttf/cqzYEOJaCgjC3H4I5HZlTngYiGK95Hdd4Gu5pUfukFMlqEM197lZzRA==
X-Received: by 2002:a17:902:758b:b0:1b8:903d:8dd0 with SMTP id j11-20020a170902758b00b001b8903d8dd0mr16761969pll.32.1689736071934;
        Tue, 18 Jul 2023 20:07:51 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id bf6-20020a170902b90600b001b890b3bbb1sm2596203plb.211.2023.07.18.20.07.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Jul 2023 20:07:51 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Date:   Tue, 18 Jul 2023 20:07:50 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     Naresh Solanki <naresh.solanki@9elements.com>
Cc:     devicetree@vger.kernel.org, Jean Delvare <jdelvare@suse.com>,
        linux-kernel@vger.kernel.org, linux-hwmon@vger.kernel.org,
        Patrick Rudolph <patrick.rudolph@9elements.com>
Subject: Re: [PATCH v2 7/8] hwmon: (pmbus/mp2975) Add regulator support
Message-ID: <8e209b78-8d81-4dfc-a88f-a11bbe4b03f0@roeck-us.net>
References: <20230714135124.2645339-1-Naresh.Solanki@9elements.com>
 <20230714135124.2645339-7-Naresh.Solanki@9elements.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230714135124.2645339-7-Naresh.Solanki@9elements.com>
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

On Fri, Jul 14, 2023 at 03:51:15PM +0200, Naresh Solanki wrote:
> From: Patrick Rudolph <patrick.rudolph@9elements.com>
> 
> Add support to expose the PMBUS regulator.
> 
> Tested on MP2973 and MP2971.
> 
> Signed-off-by: Patrick Rudolph <patrick.rudolph@9elements.com>
> Signed-off-by: Naresh Solanki <Naresh.Solanki@9elements.com>

Applied.

Thanks,
Guenter
