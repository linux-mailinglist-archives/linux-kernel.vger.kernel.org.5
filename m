Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 51ABD7B05F2
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Sep 2023 16:01:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232020AbjI0OBI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Sep 2023 10:01:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54164 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231758AbjI0OBG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Sep 2023 10:01:06 -0400
Received: from mail-pf1-f180.google.com (mail-pf1-f180.google.com [209.85.210.180])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C3441FC;
        Wed, 27 Sep 2023 07:01:03 -0700 (PDT)
Received: by mail-pf1-f180.google.com with SMTP id d2e1a72fcca58-690fa0eea3cso10044682b3a.0;
        Wed, 27 Sep 2023 07:01:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695823263; x=1696428063;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=3GtW+9oznn0V0LSFljbT9XRIBI5HvP917KRuivWnT/Y=;
        b=Hl5k4PQvTmMMH1WPTirVdKjgZUYPBShGucj8WpVpPzJo1PkZwl6HL1KgAKSroLSkrd
         K3X4aipbuQIKbyQx20kY79/SDsJx//TK9TNJ4zRcIHDq+6sbxDGNIkQ5PQfhBn4YAFfx
         HySDDUDO2h43biyj4xVWe9LgB6ByS0YUVNTWYveTRtZRiVbKi8VLwid0DNFErSE0n3sM
         4EyUW949TKMLAtzb91kdibNrnQjevakYQnC3IdlxyLF/t6rbJpHaakPtNgLN2SHi7nqs
         5EghHUn61MCu+X3TAiN1Rftq671twBMoEjhhnTNLcGP60BrEY8xSc0BsGis+kYG3FYUL
         uQoA==
X-Gm-Message-State: AOJu0YzGRDM80/NmVbH2z/lqwc56zfte0IFwSuptAu33cupk8jMFjqZM
        d8mlvVH/FR54IxNAm3SldWg=
X-Google-Smtp-Source: AGHT+IGni2WGxmceJYlnyrHoYDWDkUDWZLSDXqVbWvbNjy8hX/6e1sGoVNyYrz0LTs15yisqk4ICTA==
X-Received: by 2002:a05:6a21:7881:b0:12e:73bb:cbb6 with SMTP id bf1-20020a056a21788100b0012e73bbcbb6mr2283615pzc.14.1695823263046;
        Wed, 27 Sep 2023 07:01:03 -0700 (PDT)
Received: from [192.168.51.14] (c-73-231-117-72.hsd1.ca.comcast.net. [73.231.117.72])
        by smtp.gmail.com with ESMTPSA id s24-20020aa78d58000000b0068fdb59e9d6sm11636790pfe.78.2023.09.27.07.01.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 27 Sep 2023 07:01:02 -0700 (PDT)
Message-ID: <fc27ebc4-36b6-4acf-a0ef-77473c5dc237@acm.org>
Date:   Wed, 27 Sep 2023 07:01:01 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] scsi: 3w-sas: Clean up errors in 3w-sas.h
Content-Language: en-US
To:     chenguohua@jari.cn, aradford@gmail.com, jejb@linux.ibm.com,
        martin.petersen@oracle.com
Cc:     linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org
References: <38a151ef.88d.18ad5d47214.Coremail.chenguohua@jari.cn>
From:   Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <38a151ef.88d.18ad5d47214.Coremail.chenguohua@jari.cn>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/27/23 01:49, chenguohua@jari.cn wrote:
> Fix the following errors reported by checkpatch:

checkpatch is a tool that should only be used to verify new patches
before posting these on a Linux kernel related mailing list. It should
not be used to "fix" old code.

Thanks,

Bart.

