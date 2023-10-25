Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 119D17D74DB
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Oct 2023 21:53:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232688AbjJYTxs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Oct 2023 15:53:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57706 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229498AbjJYTxr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Oct 2023 15:53:47 -0400
Received: from mail-pg1-x530.google.com (mail-pg1-x530.google.com [IPv6:2607:f8b0:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E0F21181;
        Wed, 25 Oct 2023 12:53:44 -0700 (PDT)
Received: by mail-pg1-x530.google.com with SMTP id 41be03b00d2f7-5ac865d1358so135920a12.3;
        Wed, 25 Oct 2023 12:53:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1698263624; x=1698868424; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=YQjLg2aKbL9jWaAizwrSUOry26XXUxk3Bd3p9prdtOA=;
        b=YRcdfgWKAO6++9BVFS3ijtEgvb/LcGQyU6wNApTO+V3FuuQL3NCS7alRUe22L5PtAW
         b1QViQdTcGXYYki1sGGbvPlpboVw0kWQpjH6dfqY2damj+TZaA4NIrSdJmO62jzz+Mpy
         8PVpzfJU2LPUSerKKSXu3O13k98W4VUkARq1ufo7YK57VgpYGZLvUz6Nxa/qU1C/2fna
         OS8W1qiLGeuo49wrXTATDag82OgrKv+1LiGrYk4QC9596etlzG1AFkRpzxGwXdxBgnUo
         cEYRwf9eeaW0R8HgSsnZjpWPcslgH3Oi+2ZqFPMgbpRrKAz/qjfV0zLehTKQbJwKZKGb
         Awtw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698263624; x=1698868424;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YQjLg2aKbL9jWaAizwrSUOry26XXUxk3Bd3p9prdtOA=;
        b=uoO8AhNu42YM4XWvy9ECyQ6HLWumekoiK5TQ2zPUuh5izHFEN07aXdmebJmOQrB9g9
         Q54ajosQm86DuGOQKnAnKXN5JWiz+exPSPk80Q5nWWTOE9j5YvvgP3N6IF3sDwPYSH+B
         2/jyhQslf9bQE26ESKLynIObrKDub/+fPB3sCjNmYPmDcUpUR28GGFp7KmTuzfk4AOV6
         I/8crChSxpndWWTRzUudEH7KTXcL58iq9fTi4W5eVLVeHdqnnXv74iwlwEnGNMtgM1sm
         5a/oE9sWvzOvroKDFsPF+9urWploRXB50LYF/Nx3WNYMbqBTLrZ3q8vvaMoIbxuTaYT8
         wL/A==
X-Gm-Message-State: AOJu0YwLtlhRyjwiqLgr0/JlrbmY2qrhdij2ZjGtvIOAFPi3d6p+rN6i
        1zFay7hLGZDB7xXoJEINRHr81eKxQjM=
X-Google-Smtp-Source: AGHT+IFW+jd24bOEKuhU+1oi+8QarCoh+KSuzxP557Cgnd20gGGn02jnIDUrsUQ9UuXlDsjENsueCg==
X-Received: by 2002:a17:90b:4c0d:b0:27d:3c7c:be84 with SMTP id na13-20020a17090b4c0d00b0027d3c7cbe84mr12766913pjb.30.1698263624317;
        Wed, 25 Oct 2023 12:53:44 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id nv18-20020a17090b1b5200b0027ce36075d7sm259595pjb.53.2023.10.25.12.53.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Oct 2023 12:53:43 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Date:   Wed, 25 Oct 2023 12:53:43 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     Zev Weiss <zev@bewilderbeest.net>
Cc:     Jean Delvare <jdelvare@suse.com>, linux-hwmon@vger.kernel.org,
        Joel Stanley <joel@jms.id.au>, linux-kernel@vger.kernel.org,
        Thomas Zajic <zlatko@gmx.at>, stable@vger.kernel.org
Subject: Re: [PATCH] hwmon: nct6775: Fix incorrect variable reuse in fan_div
 calculation
Message-ID: <c186bb4b-9249-449e-8095-ff2b367731c5@roeck-us.net>
References: <20230929200822.964-2-zev@bewilderbeest.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230929200822.964-2-zev@bewilderbeest.net>
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

On Fri, Sep 29, 2023 at 01:08:23PM -0700, Zev Weiss wrote:
> In the regmap conversion in commit 4ef2774511dc ("hwmon: (nct6775)
> Convert register access to regmap API") I reused the 'reg' variable
> for all three register reads in the fan speed calculation loop in
> nct6775_update_device(), but failed to notice that the value from the
> first one (data->REG_FAN[i]) is actually used in the call to
> nct6775_select_fan_div() at the end of the loop body.  Since that
> patch the register value passed to nct6775_select_fan_div() has been
> (conditionally) incorrectly clobbered with the value of a different
> register than intended, which has in at least some cases resulted in
> fan speeds being adjusted down to zero.
> 
> Fix this by using dedicated temporaries for the two intermediate
> register reads instead of 'reg'.
> 
> Signed-off-by: Zev Weiss <zev@bewilderbeest.net>
> Fixes: 4ef2774511dc ("hwmon: (nct6775) Convert register access to regmap API")
> Reported-by: Thomas Zajic <zlatko@gmx.at>
> Tested-by: Thomas Zajic <zlatko@gmx.at>
> Cc: stable@vger.kernel.org # v5.19+

Applied.

Thanks,
Guenter
