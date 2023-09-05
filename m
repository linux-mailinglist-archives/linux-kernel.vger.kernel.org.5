Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1C109792A5B
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Sep 2023 18:59:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233400AbjIEQfQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Sep 2023 12:35:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47582 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1354120AbjIEJlg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Sep 2023 05:41:36 -0400
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com [IPv6:2a00:1450:4864:20::331])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0779A1AD
        for <linux-kernel@vger.kernel.org>; Tue,  5 Sep 2023 02:41:33 -0700 (PDT)
Received: by mail-wm1-x331.google.com with SMTP id 5b1f17b1804b1-401b0d97850so24264265e9.2
        for <linux-kernel@vger.kernel.org>; Tue, 05 Sep 2023 02:41:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1693906891; x=1694511691; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=7xJD4WZzooRqeAys3kMlFGQT7fDRPnPG5AfEDZE/Wns=;
        b=m4TI9ygwrAfzqGLaugJlgkT7HLpc/Aws3UcieNeuWfnSwf7Wkyk5a02w026ydbex47
         VoWXnaNamsZRR2lJ8Se7y7ONcI+MD+Zu3SS+0wAerlcDJ28Jhg6CzG3fT+GkfOZcnjMc
         luokWVlXULDfXccA1XDX8flVX4KcV+K8yi33opgu6Fa8FP8LYTM2ctyHlyU6Vbgzf3hu
         GBV5lGaLtRdkM6semaiEUMjjee5Q6F60R/vxD8dc6yj2Bp/pHVDNL/ds8UkPrRG7MHPj
         Z5YXh4nJ6JVgeUSVdwe1WMtbomxtCU4C6CG82uTVD4Aj9F0XDkiK4zHaWTkzLtMPjtxa
         w9bQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693906891; x=1694511691;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7xJD4WZzooRqeAys3kMlFGQT7fDRPnPG5AfEDZE/Wns=;
        b=De7O6K0HnGtg2a1zxIx1L5azTwnbZuQ4Dgr+K9pGDZVBOKky4TRI3/Qv/Econm3M/f
         84bnfC3yCb/7sfK/9G8saFDoxlpOHZ9HcXKoMeaKBqn0zquOCNdBbYa4O7A8CgtE3QrU
         0ViSOXfR1NX+G0SfDijKrsclF1JvU4iDdKlyHMBT9C0sGI38RwF3It2kR/BuJ7rW7Ezo
         YOWzlvFgpUR2C3GmvXFWyNT5hRKWCyPY9oENoHDPMenfWjokhJrfo5uZHfP3YD7e/fxr
         LPUqPc/76c/g1/CfKQqOELcoI9lF+6xWnFxUd/6n545E3WQiU36LbNEpphIorkkBhSiZ
         +iNg==
X-Gm-Message-State: AOJu0YwjizfO8GEYtr0EGwy+ChgE3LPqfUDeQmDWYBlgI/QSDNVKp4/s
        mj/5WBt8KDJ8Gdopq0OLfXO9Eg==
X-Google-Smtp-Source: AGHT+IEJwZxZXiRrwIx12aJkx7UtlPucJ+t0epYniwlLopc18cGms6bY6YAxIWaBO20cE1QEysaciA==
X-Received: by 2002:a5d:4591:0:b0:31d:d977:4e3d with SMTP id p17-20020a5d4591000000b0031dd9774e3dmr9934077wrq.19.1693906891481;
        Tue, 05 Sep 2023 02:41:31 -0700 (PDT)
Received: from localhost ([102.36.222.112])
        by smtp.gmail.com with ESMTPSA id q12-20020adffecc000000b00316eb7770b8sm17106364wrs.5.2023.09.05.02.41.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Sep 2023 02:41:31 -0700 (PDT)
Date:   Tue, 5 Sep 2023 12:41:28 +0300
From:   Dan Carpenter <dan.carpenter@linaro.org>
To:     Oliver Crumrine <ozlinux@hotmail.com>
Cc:     gregkh@linuxfoundation.org, colin.i.king@gmail.com,
        sumitraartsy@gmail.com, u.kleine-koenig@pengutronix.de,
        geert@linux-m68k.org, linux-kernel@vger.kernel.org,
        linux-staging@lists.linux.dev
Subject: Re: [PATCH v3 1/6] staging: octeon: clean up the octeon ethernet
 driver
Message-ID: <e76545f3-b6f6-4bf0-a854-2bc33b743759@kadam.mountain>
References: <cover.1693180346.git.ozlinux@hotmail.com>
 <PH7PR11MB7643335E674EE3396E78E004BCE1A@PH7PR11MB7643.namprd11.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <PH7PR11MB7643335E674EE3396E78E004BCE1A@PH7PR11MB7643.namprd11.prod.outlook.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Aug 27, 2023 at 07:58:17PM -0400, Oliver Crumrine wrote:
> Make the octeon ethernet driver better adhere to the
> kernel coding standard.

This is way way way too vague.  It should be something like:

Checkpatch complains about "quoted text".  Remove the typedef and use
the raw enum instead.

regards,
dan carpenter

