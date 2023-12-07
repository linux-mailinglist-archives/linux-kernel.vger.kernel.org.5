Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 629A280898E
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Dec 2023 14:53:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1442225AbjLGNxj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Dec 2023 08:53:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50056 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1442098AbjLGNxi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Dec 2023 08:53:38 -0500
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com [IPv6:2a00:1450:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 077F1D5E
        for <linux-kernel@vger.kernel.org>; Thu,  7 Dec 2023 05:53:44 -0800 (PST)
Received: by mail-wr1-x42f.google.com with SMTP id ffacd0b85a97d-33348e711e0so972717f8f.1
        for <linux-kernel@vger.kernel.org>; Thu, 07 Dec 2023 05:53:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1701957222; x=1702562022; darn=vger.kernel.org;
        h=mime-version:user-agent:references:message-id:in-reply-to:subject
         :cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=VCfngSAlIwqEXssY2pmSdDNSAL/XaZG/lzXesXtgYIo=;
        b=fEQmh4R4RmIcaXkrvGb81zl9JmU+y4xrzTgeCBuXAIkdHKWin9WLJB/n/viKDwg3dP
         bIUXx3ckTE2mJsUklM5rh+7o0JQ59CezeOXIRXAIkfZ7P7+UmPUcTFVRqdHGUS4W8L8z
         2ISyf15P8mOFav6Ua5AFQBUXsSyWs8iYH53kPOyjPYZPVMYL9OXZt/iAPxxHM9o/zgQ7
         l7YqiJ/0s9tVIJTMlTWW361NuOYBYCBVfP13wFODVPw+nQH3njnplGvuAXDp9Z4aw2pc
         CQUM8LgzQe996Rb0F6R2/M4lNRlaxT2lgznJiiCmSEIR8JCAQdtlKWHZg6BnwuhUH1M7
         M0Kg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701957222; x=1702562022;
        h=mime-version:user-agent:references:message-id:in-reply-to:subject
         :cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VCfngSAlIwqEXssY2pmSdDNSAL/XaZG/lzXesXtgYIo=;
        b=H8HLkGyPSX3bTIGXTychHiX0l1SJu1/44YLeWv70wG597s29/SlBaD2o/8qgNzVbWU
         a2ZkomsbbGVM9i7mQcezfqkz3QAT3Bc7VYXdveRDeX6oYvZDKqmo2fIwKxWAZ35kcvtE
         LGKQSGefyqUh7tTwSE+h2oMUFwjlwM3zZPnEXInTsXomj3/SQVKHxZ/EttuHN/njVEvI
         KP+IQfPxxyzPsYItPjQMwca5IUKUVWxV+nOxpvpAhZ7jMk7VS57gaX9G3rwP3dHMSLh2
         PJH7PDPwVWMX0UWmqlYp8+ZXpzoUUqP9FNizOC19Ix327KEaoVc3bsNVifaiw7VZPHr+
         myGQ==
X-Gm-Message-State: AOJu0Ywxjpxs+78/Peq+V+0VBGLkYCWiHV3AISUMSmQDcDfTbuEPJzMI
        r57ktMBH/SoDY854eoNrH823Zg==
X-Google-Smtp-Source: AGHT+IHfIhZ9GGAZ8MfZ3L3Ia3csFxydF02wtcAFIuRc7oZemDBZE6mMuWwcwbCzPvAhz1n0wfu+/A==
X-Received: by 2002:adf:f50d:0:b0:333:6435:a0e9 with SMTP id q13-20020adff50d000000b003336435a0e9mr1633119wro.79.1701957222529;
        Thu, 07 Dec 2023 05:53:42 -0800 (PST)
Received: from localhost ([193.86.92.180])
        by smtp.gmail.com with ESMTPSA id w8-20020adfcd08000000b003334675634bsm1509505wrm.29.2023.12.07.05.53.42
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 07 Dec 2023 05:53:42 -0800 (PST)
From:   Jiri Kosina <jkosina@suse.com>
X-Google-Original-From: Jiri Kosina <jikos@kernel.org>
Date:   Thu, 7 Dec 2023 14:53:43 +0100 (CET)
To:     srinivas pandruvada <srinivas.pandruvada@linux.intel.com>
cc:     Kai-Heng Feng <kai.heng.feng@canonical.com>,
        benjamin.tissoires@redhat.com, linux-pm@vger.kernel.org,
        linux-pci@vger.kernel.org,
        Jian Hui Lee <jianhui.lee@canonical.com>,
        Even Xu <even.xu@intel.com>, linux-input@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] HID: intel-ish-hid: ipc: Rework EHL OOB wakeup
In-Reply-To: <6776742e5aba8f9f10c661a7876eb252f4ac7745.camel@linux.intel.com>
Message-ID: <nycvar.YFH.7.76.2312071453340.29220@cbobk.fhfr.pm>
References: <20231108121940.288005-1-kai.heng.feng@canonical.com> <6776742e5aba8f9f10c661a7876eb252f4ac7745.camel@linux.intel.com>
User-Agent: Alpine 2.21 (LSU 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 7 Dec 2023, srinivas pandruvada wrote:

> On Wed, 2023-11-08 at 14:19 +0200, Kai-Heng Feng wrote:
> > Since PCI core and ACPI core already handles PCI PME wake and GPE
> > wake
> > when the device has wakeup capability, use device_init_wakeup() to
> > let
> > them do the wakeup setting work.
> > 
> > Also add a shutdown callback which uses pci_prepare_to_sleep() to let
> > PCI and ACPI set OOB wakeup for S5.
> > 
> > Cc: Jian Hui Lee <jianhui.lee@canonical.com>
> > Signed-off-by: Kai-Heng Feng <kai.heng.feng@canonical.com>
> Acked-by: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>

Thanks, applied.

-- 
Jiri Kosina
SUSE Labs

