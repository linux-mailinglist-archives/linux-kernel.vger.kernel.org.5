Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F0ADC79FC47
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Sep 2023 08:45:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235580AbjINGpU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Sep 2023 02:45:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35854 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232171AbjINGpS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Sep 2023 02:45:18 -0400
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com [IPv6:2a00:1450:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E96ACCC
        for <linux-kernel@vger.kernel.org>; Wed, 13 Sep 2023 23:45:14 -0700 (PDT)
Received: by mail-wr1-x435.google.com with SMTP id ffacd0b85a97d-31f8a05aa24so553879f8f.1
        for <linux-kernel@vger.kernel.org>; Wed, 13 Sep 2023 23:45:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1694673912; x=1695278712; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=qciRX+mxJBBHRMzVMlIssNJGjXlizxRyZBvLkx7U7fE=;
        b=JTaK5E5WeLjqYX1C5+GzqvJpnjEYFUttbFL+31zYY0aRSBxiAeMQfVga0MvQbuLdEr
         x0ISGAfZDchzTvsweTTRhaaMZd7nS2ysJvhv9Bh+Nz3DqD3OudKv6+gwer7riis5Ouk9
         GDbvRVmP32SOkPZ6S1iPVn0Zce26hmwZzGy90drPGW/jEyAQxI+IMd2uPXNm5P3/06im
         uVPPynKW4DFszRbROQU015MuYKPhT5mAcOLaBfRgi2jWcn2g5inM7AUN31bK+QC7TY0z
         lHO4DfFXHAGh/x2d25cI6PL9VHfQkGf2L1OHn0ESlvRXxisZle4vKQSaPC3Bcf9ISgQ6
         mWJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694673912; x=1695278712;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qciRX+mxJBBHRMzVMlIssNJGjXlizxRyZBvLkx7U7fE=;
        b=lPCoxZKSsOUBY+MtLBta5u1lr10FS3IwBxWMLRWi4gupPmQ5IIsimM4QjGovY1bSV2
         u2Nbqh22CZ5AKQgyD2eeHGEUA9WX6PgS3CmzujGCTXV9eYTCjqVUvv3k4XhZKK1tJev1
         tza24pSOA882PqDuSzgEjwI+ty5jmmM86PVuczxtBTz/TQaXIaN4A9kyW3g70Kq/Ugko
         bUSiur1FJOOQ3tGNpMhDzaQ+dwAsrvbJ4S72yDjGWl9eV6onXrB7qMofejpqswTkp5M8
         XgsEG3C3VZUofYJZtuEtBh8drNGCg942EYD36LYHcTNN3bwIPstLlLnx5z/FgxSVJuk2
         k9cA==
X-Gm-Message-State: AOJu0YwY4CnmLsfKLgfpbkj3S3LTZx4NYAXwHwrtF5GLtKRmNWIe0Cj3
        v7na3JCPFakxLvH5r1z/rreZQA==
X-Google-Smtp-Source: AGHT+IHe7UCEpR+G+JyVeTmGXSRIMzrAAHrOS6yN9jozComNQvSSilZ54N6s5sU/SwELgdKIAspvGg==
X-Received: by 2002:a5d:458b:0:b0:318:7d5:67bf with SMTP id p11-20020a5d458b000000b0031807d567bfmr3770811wrq.49.1694673912687;
        Wed, 13 Sep 2023 23:45:12 -0700 (PDT)
Received: from localhost ([102.36.222.112])
        by smtp.gmail.com with ESMTPSA id y12-20020adfee0c000000b0031aca6cc69csm861825wrn.2.2023.09.13.23.45.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Sep 2023 23:45:12 -0700 (PDT)
Date:   Thu, 14 Sep 2023 09:45:09 +0300
From:   Dan Carpenter <dan.carpenter@linaro.org>
To:     Umang Jain <umang.jain@ideasonboard.com>
Cc:     linux-staging@lists.linux.dev,
        linux-arm-kernel@lists.infradead.org,
        linux-rpi-kernel@lists.infradead.org, linux-media@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Stefan Wahren <stefan.wahren@i2se.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Adrien Thierry <athierry@redhat.com>,
        Dan Carpenter <error27@gmail.com>,
        Dave Stevenson <dave.stevenson@raspberrypi.com>,
        Kieran Bingham <kieran.bingham@ideasonboard.com>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Subject: Re: [PATCH v11 5/5] staging: vc04_services: vchiq_arm: Remove
 vchiq_register_child()
Message-ID: <44275d78-7318-4a28-b048-01b60f90d2fc@kadam.mountain>
References: <20230913195354.835884-1-umang.jain@ideasonboard.com>
 <20230913195354.835884-6-umang.jain@ideasonboard.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230913195354.835884-6-umang.jain@ideasonboard.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 14, 2023 at 01:23:54AM +0530, Umang Jain wrote:
> vchiq_register_child() is used to registered child devices as platform
> devices. Now that the child devices are migrated to use the
> vchiq_bus_type instead, they will be registered to that. Hence, drop
> vchiq_register_child() as it is no more required.

This needs to be folded together with patch 4.  Otherwise it introduces
a compile warning which breaks git bisect.  (I haven't tested this so
I'm going to be so embarrassed if I'm wrong).

regards,
dan carpenter

