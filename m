Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E05EB7A8E3D
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Sep 2023 23:10:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230207AbjITVKr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Sep 2023 17:10:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44712 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230053AbjITVKp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Sep 2023 17:10:45 -0400
Received: from mail-qv1-xf36.google.com (mail-qv1-xf36.google.com [IPv6:2607:f8b0:4864:20::f36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A2AFAB9
        for <linux-kernel@vger.kernel.org>; Wed, 20 Sep 2023 14:10:38 -0700 (PDT)
Received: by mail-qv1-xf36.google.com with SMTP id 6a1803df08f44-65628b1181cso1301996d6.1
        for <linux-kernel@vger.kernel.org>; Wed, 20 Sep 2023 14:10:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1695244238; x=1695849038; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cXVITGDPGvQXDKgdBYzXMtxm4MnaABDXn0LhtEv8kjo=;
        b=tuNgEJSg44nwNJy7oYjUWb1KHefDQOJHHZoLTxlzjw2hVIMNUV5WJkWamnnYu7Ct+U
         Lx9TNV4WeKVnG1nrl4pJp2c3x4xF6DfVy87n7drDdP7Dtehyj+iQwyywgX9JjnE5blur
         wQVPgQ15VQDHe8rseKMqO1PlHsk8p8tsp1Iv8pNJhtTqBitpjh0IRzA7CMxS8Cpy1vF/
         cQQ03llSSDRtxTDTpSpqWHodksAgzyukiUryUWPRqkfzI/Bya0ZhXyxFOhhlTc2Aj3c1
         sJNOlPQrPuLrOdpFV+z/Us1vGiS4djw/OVU3hfSzeh7yPwX+u0V3OZipSBlQUhJlTYFu
         nkMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695244238; x=1695849038;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=cXVITGDPGvQXDKgdBYzXMtxm4MnaABDXn0LhtEv8kjo=;
        b=B1/53mZSHsNgurZKjMuy53K8EOVZmy8A15gfKHnTFn113xEv2rLJeaDZxEh0RBn1m8
         dn5j8HUYq6ZyVLjv/QYdPjHvBTlUQssLN18CKitpxJsxmIHIFCpychs9NAFSAOJf5+e4
         FXeHoOooQoQnAJlt/90D9jyhr4P/yrxt/qu7iqjkCfETBSZhkh9tkMqTW2flELrvbrUe
         THLe2t6REsrZJCTWAMJDANLMxuWgQETquzmHBF/VrhVZYvSEU/TQzyS6fDCxEjQ9SGSD
         RBzsNePdTm6h8DLdfvALDSlsbulhp/xEW+qcafAQLwKwr1RO+lgdwbaCXWpRW8wwXrwf
         MSEg==
X-Gm-Message-State: AOJu0YwCSbBgMqpLmRlK96zxQtTYxf/8tVnDRiGS9QHt1EuCv6hn0SDz
        uUjxOpGihzqTL5ITsZPC+yU3gJXDImzUfTfuU5V2EQ==
X-Google-Smtp-Source: AGHT+IHF+PKtY/XLs6DFjozMcBQSZrG+xGJgOF7lfnIvU2EVUGfVMIHmP5vBzDPomAit7X5jsh51N08gENI1hJXfk/Y=
X-Received: by 2002:a05:6214:398b:b0:657:ace:63eb with SMTP id
 ny11-20020a056214398b00b006570ace63ebmr3576716qvb.54.1695244237653; Wed, 20
 Sep 2023 14:10:37 -0700 (PDT)
MIME-Version: 1.0
References: <20230914031349.23516-1-sathyanarayanan.kuppuswamy@linux.intel.com>
In-Reply-To: <20230914031349.23516-1-sathyanarayanan.kuppuswamy@linux.intel.com>
From:   Erdem Aktas <erdemaktas@google.com>
Date:   Wed, 20 Sep 2023 14:10:26 -0700
Message-ID: <CAAYXXYy0yh8CvnmatUwcUe28G37kEJoE8ZVTtNJU3+Y7SDnfzA@mail.gmail.com>
Subject: Re: [PATCH v2] virt: tdx-guest: Add Quote generation support using TSM_REPORTS
To:     Kuppuswamy Sathyanarayanan 
        <sathyanarayanan.kuppuswamy@linux.intel.com>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Dan Williams <dan.j.williams@intel.com>,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
        "H . Peter Anvin" <hpa@zytor.com>, Tony Luck <tony.luck@intel.com>,
        Wander Lairson Costa <wander@redhat.com>,
        Dionna Amalie Glaze <dionnaglaze@google.com>,
        Qinkun Bao <qinkun@apache.org>,
        Guorui Yu <GuoRui.Yu@linux.alibaba.com>,
        linux-coco@lists.linux.dev, x86@kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 13, 2023 at 8:14=E2=80=AFPM Kuppuswamy Sathyanarayanan
<sathyanarayanan.kuppuswamy@linux.intel.com> wrote:
>
> In TDX guest, the attestation process is used to verify the TDX guest
> trustworthiness to other entities before provisioning secrets to the
> guest. The First step in the attestation process is TDREPORT
> generation, which involves getting the guest measurement data in the
> format of TDREPORT, which is further used to validate the authenticity
> of the TDX guest. TDREPORT by design is integrity-protected and can
> only be verified on the local machine.
>
> To support remote verification of the TDREPORT (in a SGX-based
> attestation), the TDREPORT needs to be sent to the SGX Quoting Enclave
> (QE) to convert it to a remotely verifiable Quote. SGX QE by design can
> only run outside of the TDX guest (i.e. in a host process or in a
> normal VM) and guest can use communication channels like vsock or
> TCP/IP to send the TDREPORT to the QE. But for security concerns, the
> TDX guest may not support these communication channels. To handle such
> cases, TDX defines a GetQuote hypercall which can be used by the guest
> to request the host VMM to communicate with the SGX QE. More details
> about GetQuote hypercall can be found in TDX Guest-Host Communication
> Interface (GHCI) for Intel TDX 1.0, section titled
> "TDG.VP.VMCALL<GetQuote>".
>
> Trusted Security Module (TSM) [1] exposes a common ABI for Confidential
> Computing Guest platforms to get the measurement data via ConfigFS.
> Extend the TSM framework and add support to allow an attestation agent
> to get the TDX Quote data (included usage example below).
>
>   report=3D/sys/kernel/config/tsm/report/report0
>   mkdir $report
>   dd if=3D/dev/urandom bs=3D64 count=3D1 > $report/inblob
>   hexdump -C $report/outblob
>   rmdir $report
>
> GetQuote TDVMCALL requires TD guest pass a 4K aligned shared buffer
> with TDREPORT data as input, which is further used by the VMM to copy
> the TD Quote result after successful Quote generation. To create the
> shared buffer, allocate a large enough memory and mark it shared using
> set_memory_decrypted() in tdx_guest_init(). This buffer will be re-used
> for GetQuote requests in the TDX TSM handler.
>
> Although this method reserves a fixed chunk of memory for GetQuote
> requests, such one time allocation can help avoid memory fragmentation
> related allocation failures later in the uptime of the guest.
>
> Since the Quote generation process is not time-critical or frequently
> used, the current version uses a polling model for Quote requests and
> it also does not support parallel GetQuote requests.
>
> Link: https://lore.kernel.org/lkml/169342399185.3934343.30358453483269445=
19.stgit@dwillia2-xfh.jf.intel.com/ [1]
> Signed-off-by: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@lin=
ux.intel.com>
> ---
>
> Hi All,
>
> The original version of this patch series [1] added support for TDX
> Guest Quote generation via an IOCTL interface. Since we have multiple
> vendors implementing such interface, to avoid ABI proliferation, Dan
> proposed using a common ABI for it and submitted the Trusted Secure
> module (TSM) report ABI support [2]. This patchset extends the
> TSM REPORTS to implement the TDX Quote generation support. Since there
> is a change in interface type, I have dropped the previous Acks.
>
> [1] https://lore.kernel.org/lkml/3c57deb0-a311-2aad-c06b-4938e33491b5@lin=
ux.intel.com/
> [2] https://lore.kernel.org/lkml/169342399185.3934343.3035845348326944519=
.stgit@dwillia2-xfh.jf.intel.com/
>
> Changes since v1:
>  * Used mutext_lock_interruptible() for quote_lock to allow user
>    interruption.
>  * Used msleep_interruptible() instead of ssleep() to allow user
>    interruption.
>  * Added check for the set_memory_encrypted() return value.
>  * Fixed typos in comments and commit log.
>
Thanks for the changes, the patch looks good to me.
Reviewed-by : Erdem Aktas <erdemaktas@google.com>
