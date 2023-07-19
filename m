Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2989C758BBC
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Jul 2023 05:03:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230218AbjGSDDN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Jul 2023 23:03:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38236 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230209AbjGSDDJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Jul 2023 23:03:09 -0400
Received: from mail-pg1-x52f.google.com (mail-pg1-x52f.google.com [IPv6:2607:f8b0:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7A6391BF0;
        Tue, 18 Jul 2023 20:03:08 -0700 (PDT)
Received: by mail-pg1-x52f.google.com with SMTP id 41be03b00d2f7-5577004e21bso2712343a12.2;
        Tue, 18 Jul 2023 20:03:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1689735788; x=1692327788;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=O6Q4Gr5aTOSuGEpQsnLnXjoJVut5P5cv2RZkLBpYF2c=;
        b=KdUJZCNqNtRGIW9mfRkwXt5/4suDubL/MztFLizONKQfCxMZe5a7yieLemqQJwT+zh
         7O+XHfuKSFunySoHLcypQK9L5i90iHMM8MBeHQkPgl5QWoKZko7vSx7ApEIwtFKcAHCj
         GQ5q93LZBVW8UExcVp2EqPZSgVnQdftdE/jFAoSUwfkqfp4fSoa57bCNxG5EdsAHTcu1
         rRJ2kYdA4H8ZcoJG2HxU3h0Ep/t6RzXPH1O3X0PKfWBNsizTcpeDqklfXOo2UpTbYaXD
         X5ZXL0ULJWCXYGffrRhLlar1D9nv7duEGUfixsxpTF9igmRgy45pFSTMuRakV7S3a/x1
         esWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689735788; x=1692327788;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=O6Q4Gr5aTOSuGEpQsnLnXjoJVut5P5cv2RZkLBpYF2c=;
        b=LsUy3Govuz7MhEYjFzeV2Tx7Cv9lVkR4sKFOqc/zsuNkf/2Dq+nh9mxTyVqo4NU0pB
         PQaKkzFqiRcY3rVbYcAyT+8eIu1psR3BK0qL6BDwWOWW9jgcVrtehkB3vRpqdla3Sx4r
         P4yu/SiVMpTpHRE9NK9opVO2EjKqjAg8+9LrsTIkHJsCHuseeGspE0vMPfoSThNaI5Gm
         QQdPDA2UutlWiGm4ucgTpZuLsyYtI0ILWYItGu+1xaT4mrPI8S7SxVTM3RuWdmCCWoYs
         TTRrJaJOqfqJzJFDxqSlVYDP6UBEGQFm7gj9e8CahdAcB9Q7qjxMfJzqUY9BPQO948mx
         DLQw==
X-Gm-Message-State: ABy/qLY6DlX8XlHFsF/JHE1I0N7hzAa49Uv2+YOzas7lAp3RREbgiNCG
        tvKaOYRV3hLAqSVHxqaH94ww71dcbjo=
X-Google-Smtp-Source: APBJJlEPTmQwFFpXblUkAudk+z1dg+vzkVrVSVR33gnNf2cyBqIIVokJEY8hPdxfUrNUo78ZY9xR+w==
X-Received: by 2002:a17:902:e809:b0:1ba:1704:8a12 with SMTP id u9-20020a170902e80900b001ba17048a12mr4372188plg.45.1689735787910;
        Tue, 18 Jul 2023 20:03:07 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id ba12-20020a170902720c00b001b9d9225b78sm2602876plb.102.2023.07.18.20.03.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Jul 2023 20:03:07 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Date:   Tue, 18 Jul 2023 20:03:06 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     Naresh Solanki <naresh.solanki@9elements.com>
Cc:     devicetree@vger.kernel.org, Jean Delvare <jdelvare@suse.com>,
        linux-kernel@vger.kernel.org, linux-hwmon@vger.kernel.org,
        Patrick Rudolph <patrick.rudolph@9elements.com>
Subject: Re: [PATCH v2 3/8] hwmon: (pmbus/mp2975) Prepare for MP2973 and
 MP2971
Message-ID: <5dc4825b-3c17-42c7-b2b8-d804ba355dbc@roeck-us.net>
References: <20230714135124.2645339-1-Naresh.Solanki@9elements.com>
 <20230714135124.2645339-3-Naresh.Solanki@9elements.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230714135124.2645339-3-Naresh.Solanki@9elements.com>
X-Spam-Status: No, score=-1.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 14, 2023 at 03:51:11PM +0200, Naresh Solanki wrote:
> From: Patrick Rudolph <patrick.rudolph@9elements.com>
> 
> Add support for differntiating between the chips.
> The following commits will make use of this mechanism.
> 
> Signed-off-by: Patrick Rudolph <patrick.rudolph@9elements.com>
> Signed-off-by: Naresh Solanki <Naresh.Solanki@9elements.com>

Applied.

Thanks,
Guenter
