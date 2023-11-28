Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 337F87FC1C5
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Nov 2023 19:15:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345955AbjK1PBm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Nov 2023 10:01:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34324 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345929AbjK1PBj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Nov 2023 10:01:39 -0500
Received: from mail-qt1-x829.google.com (mail-qt1-x829.google.com [IPv6:2607:f8b0:4864:20::829])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 620FC1B6
        for <linux-kernel@vger.kernel.org>; Tue, 28 Nov 2023 07:01:46 -0800 (PST)
Received: by mail-qt1-x829.google.com with SMTP id d75a77b69052e-423e04781d3so102691cf.0
        for <linux-kernel@vger.kernel.org>; Tue, 28 Nov 2023 07:01:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1701183705; x=1701788505; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=51z15QLCTvUCxMQGRCe0dIJ/n54kd0sYe/k+835mZ+Q=;
        b=YuqoL6rA3uuOkl8O2VFudG+nU+jD/4CNGD63jsk6OSrXUnZbiDD/qfuEr732ynH/Na
         tohYIOH9fw4DAGUrCc0aNuioZH14ytEzkR+ie8xVBxg5DEJMqANaLVCLYn9RDFa0JX2A
         dcJNpJ7N5xozOOzOvHwRvfVmhEWb0NMqXOgW3kEGFtVjGPS1zr0aB/l97hlhmXbElnmp
         5Z2YwOjvh5oJ2ABRxNhMCa9Pku8xJeGNfSSCd6tCsMDsefxyzAnllEO2jd3ONVWIIJOo
         ilpxXWJ+zUdN/HqK3HDwrpHTqszE0ClevArOauGwQ2fnPCrCfiRiXv3Xh4v+MOlfnh5S
         GWHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701183705; x=1701788505;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=51z15QLCTvUCxMQGRCe0dIJ/n54kd0sYe/k+835mZ+Q=;
        b=UOTtgooCHwERTZczjAxzM1VlOCGJE9k+uk1gSMVMqK47Kt+dG/rwFFhMWi9WWZP03T
         qjbaYYjNMDySQo5XtrEs3FvGUgNx452azFy0nTWLk55rti0c29f3s8MWNqltHcMF5k9Y
         DYlW/gDMEJylzZgxAkDpVbQqSOHcJnEz72pYjLMXnpWhMZOGqJUXeaaTppUgLUVfC3Z6
         NVPtDU7VJc7dbS2YF3uD7fwwF6umOdDYqVxT8Rngv0JkXhLyBp3wwCBfC3gTTXtOPz8/
         CyrbFYO6lQB4AwtGFz/51U3T5UdyLlAOBnGhUpNA8Ijer4wNmKD8WWFcOHhzCfSc5lzz
         /2+w==
X-Gm-Message-State: AOJu0YydqjgEkeIRBr2TfrIlh6Wb+3c6iD9mqBt/YPkRj/30uuOLL2Qf
        PVzl1CyJ+yEY0zKhTtyepD8sZ08RfsVwOGB9PZfjk7jUJCTo16u2tBAdRw==
X-Google-Smtp-Source: AGHT+IEnnqJc8lfN5xFbLFc8UvzSuJ8lofgbBb9+EyaycetBPAnEURXmIxIBlynaUktSHJ8NHBsB7/YPd8aGr7GZzso=
X-Received: by 2002:ac8:59ca:0:b0:420:c750:c244 with SMTP id
 f10-20020ac859ca000000b00420c750c244mr1118141qtf.12.1701183705214; Tue, 28
 Nov 2023 07:01:45 -0800 (PST)
MIME-Version: 1.0
References: <20231117072131.2886406-1-khtsai@google.com> <a4a129a3-e271-acbb-949c-534a8e1627ee@linux.intel.com>
 <CAKzKK0rnx+tSFAj6N-U_vcAZ_5P=Hx_Kb97NFkdPMHs8dR3Ukw@mail.gmail.com>
 <a970f296-da67-9a80-ab2f-a94fd16e0fd9@linux.intel.com> <51b8fc3d-25ef-1ab3-d744-8d851a133828@linux.intel.com>
In-Reply-To: <51b8fc3d-25ef-1ab3-d744-8d851a133828@linux.intel.com>
From:   Kuen-Han Tsai <khtsai@google.com>
Date:   Tue, 28 Nov 2023 23:01:17 +0800
Message-ID: <CAKzKK0r_a_8uWTxjupDwwHH9hyCUd_NNTojL=209FiEzrcK9fw@mail.gmail.com>
Subject: Re: [PATCH] xhci: fix null pointer deref for xhci_urb_enqueue
To:     Mathias Nyman <mathias.nyman@linux.intel.com>
Cc:     mathias.nyman@intel.com, gregkh@linuxfoundation.org,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        alan Stern <stern@rowland.harvard.edu>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Thank you so much for fixing the issue, Mathias!

> I moved the max packet checks away from xhci_urb_enqueue() and fixed up the locking.
> I can't trigger the original issue, but I tested it by setting incorrect initial max packet
> size values.

I added a 3-seconds delay within xhci_check_maxpacket(). When I saw
the max packet size was being checked, I removed the USB device to
trigger the race problem.

[  172.392813][ T1960] [khtsai] xhci_check_maxpacket, before,
slot_id=2, devs[slot_id]=000000003cb76fec
[  174.290601][   T20] usb 2-1: USB disconnect, device number 2
[  174.290608][   T20] usb 2-1.2: USB disconnect, device number 3
[  174.297180][   T20] [khtsai] xhci_free_dev, ret=1
[  174.305010][  T133] usb usb3: USB disconnect, device number 1
[  174.316346][   T20] [khtsai] xhci_free_dev, ret=1
[  175.458962][ T1960] [khtsai] xhci_check_maxpacket, after,
slot_id=2, devs[slot_id]=0000000000000000
[  175.460835][ T1960] Unable to handle kernel NULL pointer
dereference at virtual address 0000000000000010

> If you have the chance to test this with your setup I'd appreciate it.

Sure, I will definitely help verify it. However, I believe the race
problem won't happen as your patch already removes max packet checks
from xhci_urb_enqueue() and also protects sections using the
xhci->devs[slot_id] virtual device.

> patches found here:
> git://git.kernel.org/pub/scm/linux/kernel/git/mnyman/xhci.git fix_urb_enqueue_locking
> https://git.kernel.org/pub/scm/linux/kernel/git/mnyman/xhci.git/log/?h=fix_urb_enqueue_locking

I'll add them to this thread as well
