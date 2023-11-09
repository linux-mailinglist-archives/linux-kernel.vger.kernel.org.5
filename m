Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2C62C7E7519
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Nov 2023 00:26:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345383AbjKIX0E (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Nov 2023 18:26:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37130 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229613AbjKIX0D (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Nov 2023 18:26:03 -0500
Received: from mail-pj1-x1035.google.com (mail-pj1-x1035.google.com [IPv6:2607:f8b0:4864:20::1035])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3FD92449E
        for <linux-kernel@vger.kernel.org>; Thu,  9 Nov 2023 15:26:01 -0800 (PST)
Received: by mail-pj1-x1035.google.com with SMTP id 98e67ed59e1d1-2809414efa9so1354024a91.1
        for <linux-kernel@vger.kernel.org>; Thu, 09 Nov 2023 15:26:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1699572361; x=1700177161; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Q9Ux6J5ktMDQF6/oF6DhUm4Rz889Ag+4/KakbSomJfk=;
        b=jQeZQFq4hV32SvYXzh1gpq3s9d54hXWckkEJt6fKeOSDYKevsjTVvS85fNQWXVZbqk
         +IkBb2P81u2WwnRpE0W2JK0DIBDKuuiOEzML+x1R5dHpJnYxUhcaY4bxx9y3fOami3u4
         zngGJoMWGqhRr6tt2g/G4PNwxhN6gjJjPErCSGZy43d1oAdaQi8vcOd+qHEt9bX3fceJ
         vG250iB+G4WUG/qGfn/c99doU3cQV4s4FGphdSQSxMIc2JKmktjtpERqoatobK3oUk3A
         DGK7ZsoJ/Fu+G3tV/ekVTjc6cmqpeszczz8XMKW3e73XCMNC1aAngI0RM8g0HwyqOzZP
         lfHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699572361; x=1700177161;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Q9Ux6J5ktMDQF6/oF6DhUm4Rz889Ag+4/KakbSomJfk=;
        b=LxX/A1JfiXd680OYyIRiXU6lJlpaRO3lv9vox//8F3aJE4e5ScsuUM/EvONP+7laMU
         wV89EvHD75wdZfLKYMmnRO8xy7pzcDHiiiR7af5YGqUBSbNxM8Anx1HqYFy7xCxt5WZU
         PBCBEqEdSb6TcDjbLdjpK1CXK224MATX7U+J83her3QJPZckXt2S9nl45FD9yNDYbZ2c
         1drtP+NHqugnt7ETEQg8KYsVCVicfPtFdPSG5js0x3FwDG+8DFI+sssm+3HeDG1P3cXR
         k0Ku+b0CdWc5H4vJ6vnUIKsR46bMsrimlR4vyZTRxbaihYUU8NwBtZNWFE9MRtocbjkN
         1M6A==
X-Gm-Message-State: AOJu0Yy0u4dJQuXuc6uM76wulhlOMpP7y1lpSO8hFvXJsyGZSg+nCJ2R
        W1aX7klMEFcR/DKEJjNZlZY=
X-Google-Smtp-Source: AGHT+IHmqb5rrghjC404ZAdgkTo7HoXC1w11HTOeHpgssCBYEnpbsQpvtBnpm79WrOHCysPpk2B6Ww==
X-Received: by 2002:a17:90b:3a88:b0:281:3fb:6df2 with SMTP id om8-20020a17090b3a8800b0028103fb6df2mr3110060pjb.22.1699572360431;
        Thu, 09 Nov 2023 15:26:00 -0800 (PST)
Received: from google.com ([2620:15c:9d:2:c99d:e08e:5968:1b85])
        by smtp.gmail.com with ESMTPSA id jx13-20020a17090b46cd00b00274b9dd8519sm300348pjb.35.2023.11.09.15.25.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Nov 2023 15:26:00 -0800 (PST)
Date:   Thu, 9 Nov 2023 15:25:54 -0800
From:   Dmitry Torokhov <dmitry.torokhov@gmail.com>
To:     Ankur Arora <ankur.a.arora@oracle.com>
Cc:     linux-kernel@vger.kernel.org, tglx@linutronix.de,
        peterz@infradead.org, torvalds@linux-foundation.org,
        paulmck@kernel.org, linux-mm@kvack.org, x86@kernel.org,
        akpm@linux-foundation.org, luto@kernel.org, bp@alien8.de,
        dave.hansen@linux.intel.com, hpa@zytor.com, mingo@redhat.com,
        juri.lelli@redhat.com, vincent.guittot@linaro.org,
        willy@infradead.org, mgorman@suse.de, jon.grimm@amd.com,
        bharata@amd.com, raghavendra.kt@amd.com,
        boris.ostrovsky@oracle.com, konrad.wilk@oracle.com,
        jgross@suse.com, andrew.cooper3@citrix.com, mingo@kernel.org,
        bristot@kernel.org, mathieu.desnoyers@efficios.com,
        geert@linux-m68k.org, glaubitz@physik.fu-berlin.de,
        anton.ivanov@cambridgegreys.com, mattst88@gmail.com,
        krypton@ulrich-teichert.org, rostedt@goodmis.org,
        David.Laight@aculab.com, richard@nod.at, mjguzik@gmail.com,
        Oded Gabbay <ogabbay@kernel.org>,
        Miguel Ojeda <ojeda@kernel.org>, Jens Axboe <axboe@kernel.dk>,
        Minchan Kim <minchan@kernel.org>,
        Sergey Senozhatsky <senozhatsky@chromium.org>,
        Sudip Mukherjee <sudipm.mukherjee@gmail.com>,
        Theodore Ts'o <tytso@mit.edu>,
        "Jason A. Donenfeld" <Jason@zx2c4.com>,
        Amit Shah <amit@kernel.org>, Gonglei <arei.gonglei@huawei.com>,
        "Michael S. Tsirkin" <mst@redhat.com>,
        Jason Wang <jasowang@redhat.com>,
        "David S. Miller" <davem@davemloft.net>,
        Davidlohr Bueso <dave@stgolabs.net>,
        Jonathan Cameron <jonathan.cameron@huawei.com>,
        Dave Jiang <dave.jiang@intel.com>,
        Alison Schofield <alison.schofield@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        Ira Weiny <ira.weiny@intel.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Sumit Semwal <sumit.semwal@linaro.org>,
        Christian =?iso-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>,
        Andi Shyti <andi.shyti@kernel.org>,
        Ray Jui <rjui@broadcom.com>,
        Scott Branden <sbranden@broadcom.com>,
        Chris Packham <chris.packham@alliedtelesis.co.nz>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Junxian Huang <huangjunxian6@hisilicon.com>,
        Will Deacon <will@kernel.org>, Joerg Roedel <joro@8bytes.org>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        Hans de Goede <hdegoede@redhat.com>,
        Ilpo =?iso-8859-1?Q?J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>,
        Mark Gross <markgross@kernel.org>,
        Finn Thain <fthain@linux-m68k.org>,
        Michael Schmitz <schmitzmic@gmail.com>,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        Kashyap Desai <kashyap.desai@broadcom.com>,
        Sumit Saxena <sumit.saxena@broadcom.com>,
        Shivasharan S <shivasharan.srikanteshwara@broadcom.com>,
        Mark Brown <broonie@kernel.org>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Jens Wiklander <jens.wiklander@linaro.org>,
        Alex Williamson <alex.williamson@redhat.com>,
        Helge Deller <deller@gmx.de>,
        David Hildenbrand <david@redhat.com>
Subject: Re: [RFC PATCH 85/86] treewide: drivers: remove cond_resched()
Message-ID: <ZU1qgv1QNiSJFEOZ@google.com>
References: <20231107215742.363031-1-ankur.a.arora@oracle.com>
 <20231107230822.371443-1-ankur.a.arora@oracle.com>
 <20231107230822.371443-29-ankur.a.arora@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231107230822.371443-29-ankur.a.arora@oracle.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Anhur,

On Tue, Nov 07, 2023 at 03:08:21PM -0800, Ankur Arora wrote:
> There are broadly three sets of uses of cond_resched():
> 
> 1.  Calls to cond_resched() out of the goodness of our heart,
>     otherwise known as avoiding lockup splats.

...

What about RCU stalls? The calls to cond_resched() in evdev.c and
mousedev.c were added specifically to allow RCU to run in cases when
userspace passes a large buffer and the kernel is not fully preemptable.

Thanks.

-- 
Dmitry
