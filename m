Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1A9FB776EEC
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Aug 2023 06:09:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232682AbjHJEJS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Aug 2023 00:09:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38810 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230008AbjHJEJQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Aug 2023 00:09:16 -0400
Received: from mail-oa1-x34.google.com (mail-oa1-x34.google.com [IPv6:2001:4860:4864:20::34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A9F52125;
        Wed,  9 Aug 2023 21:09:15 -0700 (PDT)
Received: by mail-oa1-x34.google.com with SMTP id 586e51a60fabf-1bfc2b68090so401311fac.3;
        Wed, 09 Aug 2023 21:09:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1691640555; x=1692245355;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=SaEqxEmWXmmnQfHDAh8ti6GbWeGVMhX+XD8AXGXHMh4=;
        b=EP4h2XaVXP2Ur5CXiFk8iw3eAW4duWiCsoPrjguCXSmaMRAdoWRk1/zqKn6YDxVC3X
         3MUShDOJd7Tv2zbiPt4RstVXWlbxpZM+OJjkrCjDrjF9mDHQZSWWjIHxVDVVCEQPUA4J
         fRppvEKpQXkPnNjD8HWW9xp1iaRnfPsydE7CMKWDPBAac1QAgMYcqRG7uMry8XYaesi9
         st04q7qQaiGvCC9W1g+EqiSWC8n/WKck98Vjms/dF0t2EV+HtJ4FW1Ukb1o0sJ5mZyQp
         1E95YZK71zpvJt7zsYrXyGMz6NuwzxjDA7DndtcOFIT4oWxm9rKblP4uy7wdnXF0CRXn
         B+vw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691640555; x=1692245355;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=SaEqxEmWXmmnQfHDAh8ti6GbWeGVMhX+XD8AXGXHMh4=;
        b=Kmkg6IhLKGKz8vlF/EQN8xeoGH7Hm9jG1vNZt3vw8nhQdzXPC7yOMECsRk3qJtzUxp
         Eckjzys/JfaFFaRsT8/ZRdMnFeImIscLavjVvbVRqXCsVzMAlPzZPFAj1qZb7pt7R9Cm
         et4qgGMUhqQAFwhW0s+JpbPUED+8RGKgcZPLRSUOmm+O/CALwgQBlrrbIJfKrImgOMNq
         tVEEKGoK6MfGQx8XZ/7A/GpmQslt2xvsjU/v7vgrULanw0fShlA5QTYeyxgqVd+1JP2e
         5F631dZCmUOnTMx1DmoY55w4dEPit5o5/yTztq4uZ0xQ6D1iELCM/nbbum5PPMBrmYyd
         02SA==
X-Gm-Message-State: AOJu0Yzl7y9DFVxLJ/e0mhs4QipuUiWWnimW37H+NGr3Ru21xfwTM6+f
        luF+vUleZCnzk3budIxDUkc=
X-Google-Smtp-Source: AGHT+IEDMcerwKOYmHeYrwBU4B2rrzvU0jHFfLxqv8QIP+qARmSwSnEhQcJXnxOOUXEbQMBVykjx+g==
X-Received: by 2002:a05:6870:240f:b0:1ba:617f:5f26 with SMTP id n15-20020a056870240f00b001ba617f5f26mr1392916oap.51.1691640554925;
        Wed, 09 Aug 2023 21:09:14 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id gg19-20020a056638691300b0042b0ce92dddsm164132jab.161.2023.08.09.21.09.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Aug 2023 21:09:14 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Date:   Wed, 9 Aug 2023 21:09:13 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     Aleksa Savic <savicaleksa83@gmail.com>
Cc:     linux-hwmon@vger.kernel.org, Jack Doan <me@jackdoan.com>,
        Jean Delvare <jdelvare@suse.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] hwmon: (aquacomputer_d5next) Add selective 200ms
 delay after sending ctrl report
Message-ID: <c151d464-da26-4c53-ba7a-d16bb8fca949@roeck-us.net>
References: <20230807172004.456968-1-savicaleksa83@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230807172004.456968-1-savicaleksa83@gmail.com>
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

On Mon, Aug 07, 2023 at 07:20:03PM +0200, Aleksa Savic wrote:
> Add a 200ms delay after sending a ctrl report to Quadro,
> Octo, D5 Next and Aquaero to give them enough time to
> process the request and save the data to memory. Otherwise,
> under heavier userspace loads where multiple sysfs entries
> are usually set in quick succession, a new ctrl report could
> be requested from the device while it's still processing the
> previous one and fail with -EPIPE. The delay is only applied
> if two ctrl report operations are near each other in time.
> 
> Reported by a user on Github [1] and tested by both of us.
> 
> [1] https://github.com/aleksamagicka/aquacomputer_d5next-hwmon/issues/82
> 
> Fixes: 752b927951ea ("hwmon: (aquacomputer_d5next) Add support for Aquacomputer Octo")
> Signed-off-by: Aleksa Savic <savicaleksa83@gmail.com>

I would have suggested to use fsleep() to avoid unnecessary
sleep times if they are small, bt I guess it doesn't make much
of a difference.

Applied.

Thanks,
Guenter
