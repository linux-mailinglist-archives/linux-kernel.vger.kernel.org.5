Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BF6FB798A32
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Sep 2023 17:48:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239801AbjIHPsP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Sep 2023 11:48:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43490 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232169AbjIHPsN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Sep 2023 11:48:13 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 56EA61FC4
        for <linux-kernel@vger.kernel.org>; Fri,  8 Sep 2023 08:47:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1694188045;
        h=from:from:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=3U/cl/tsndaoaeQmoPruixu8rVlReMM6YQ5yIyCJ0Vk=;
        b=U9OSMSTOfj5H4+rBaL8y81JudsQkn+pwagnxsdshaTnHlcx11XPBADuY86dSCGQBz1Wagw
        Tp5MruvQWXRiUXnsvw3ect3MIOqCHBgt9ArarSPplLlMyix3lC9QE0iXVoyzFd7wpoYqnk
        HAt0hX4s9XfAbuXG04z3YF9L7dDP3r4=
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com
 [209.85.160.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-516-R0w-qtHcOqSeoaI2V2s5Sg-1; Fri, 08 Sep 2023 11:47:24 -0400
X-MC-Unique: R0w-qtHcOqSeoaI2V2s5Sg-1
Received: by mail-qt1-f197.google.com with SMTP id d75a77b69052e-4121c086963so24991011cf.2
        for <linux-kernel@vger.kernel.org>; Fri, 08 Sep 2023 08:47:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694188043; x=1694792843;
        h=content-transfer-encoding:in-reply-to:organization:from:references
         :cc:to:content-language:subject:reply-to:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3U/cl/tsndaoaeQmoPruixu8rVlReMM6YQ5yIyCJ0Vk=;
        b=ajrczaxkE5fRyR/D+E/NPY1bLp6vZXwRp7D/7e/gzGOzNBQ9mpdZJUyDacyoPe2Qx5
         MdeWuLnoHqSZLZJ8gTJkqt0BXwyhQDLV4hNmavmQ5nT8QZs0ZRstuvemfYNdtyjEXS6D
         LUjNDoVAY+KK0GxHfNhB5TIalfKhf5THKR3WtUffmkbTBid+vQzkT6VaJzExUxTWHy4j
         WjmiqnsPuPSt2kJ4um96hmUsXFtLY4bbM7uTL+yln+NVD68BdYzG3Lt/xlTwNpmdbhqp
         +YOpJ4v/27/nBrbgrcGf9YPS1Vq4L/f8KX4qzm8ZUXMEgqjksEzHE3Ei+8237TGozgm3
         PsKQ==
X-Gm-Message-State: AOJu0Yz4kiRjoQ9KNbbOpN4IjvYtOdBiIY+9rqOLC4fTq+j5mCDgrDJI
        rCc9wQmdnWCldVsx/4Im9JTGdNsjeXXIp4KjIeSPCcSy9mLIEw7ogrp1w4sc8q72DzZPxQVxxFm
        q3iVoH3pfl0RLlljrBkZMJNlB
X-Received: by 2002:a05:622a:1788:b0:40f:ce6d:775e with SMTP id s8-20020a05622a178800b0040fce6d775emr2984438qtk.42.1694188043445;
        Fri, 08 Sep 2023 08:47:23 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEDZFVbTUzj0eklKyEE8MSE16L1VP81k9KRkojeXkCRm8mdUqC1GqZ6/gDLCOZRIqA+lycECw==
X-Received: by 2002:a05:622a:1788:b0:40f:ce6d:775e with SMTP id s8-20020a05622a178800b0040fce6d775emr2984422qtk.42.1694188043205;
        Fri, 08 Sep 2023 08:47:23 -0700 (PDT)
Received: from [192.168.1.5] (cpe-74-65-135-63.maine.res.rr.com. [74.65.135.63])
        by smtp.gmail.com with ESMTPSA id ew13-20020a05622a514d00b004052f71f79bsm695848qtb.74.2023.09.08.08.47.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 08 Sep 2023 08:47:22 -0700 (PDT)
Message-ID: <30bb6fe4-55eb-c878-bb14-2a23b37b6c27@redhat.com>
Date:   Fri, 8 Sep 2023 11:47:21 -0400
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Reply-To: dwalsh@redhat.com
Subject: Re: [PATCH v2] ipc: Store mqueue sysctls in the ipc namespace
Content-Language: en-US
To:     "Eric W. Biederman" <ebiederm@xmission.com>,
        Manfred Spraul <manfred@colorfullife.com>
Cc:     Alexey Gladkov <legion@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux Containers <containers@lists.linux.dev>,
        Alexander Mikhalitsyn <alexander.mikhalitsyn@virtuozzo.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Christian Brauner <christian.brauner@ubuntu.com>,
        Davidlohr Bueso <dbueso@suse.de>,
        Kirill Tkhai <ktkhai@virtuozzo.com>,
        Serge Hallyn <serge@hallyn.com>,
        Varad Gautam <varad.gautam@suse.com>,
        Vasily Averin <vvs@virtuozzo.com>,
        kernel test robot <lkp@intel.com>
References: <0f0408bb7fbf3187966a9bf19a98642a5d9669fe.1641225760.git.legion@kernel.org>
 <792dcae82bc228cd0bec1fa80ed4d2c9340b0f8f.1641296947.git.legion@kernel.org>
 <c8edba64-9b4b-1ef8-f0b3-1b4beacf1551@colorfullife.com>
 <87v8yzfilp.fsf@email.froward.int.ebiederm.org>
 <40ca86a1-ea36-0185-1ba5-c69005e46d3f@colorfullife.com>
 <87zgob87si.fsf@email.froward.int.ebiederm.org>
From:   Daniel Walsh <dwalsh@redhat.com>
Organization: Red Hat
In-Reply-To: <87zgob87si.fsf@email.froward.int.ebiederm.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 1/4/22 17:17, Eric W. Biederman wrote:
> parametres. This poses a problem in the rootless containers.

Did this ever go into the Linux kernel?

