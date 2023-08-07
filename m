Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0069D77291A
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Aug 2023 17:25:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229978AbjHGPZj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Aug 2023 11:25:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49868 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229965AbjHGPZh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Aug 2023 11:25:37 -0400
Received: from mail-ot1-x32a.google.com (mail-ot1-x32a.google.com [IPv6:2607:f8b0:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 83DB010DE
        for <linux-kernel@vger.kernel.org>; Mon,  7 Aug 2023 08:25:36 -0700 (PDT)
Received: by mail-ot1-x32a.google.com with SMTP id 46e09a7af769-6bcac140aaaso3524754a34.2
        for <linux-kernel@vger.kernel.org>; Mon, 07 Aug 2023 08:25:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1691421936; x=1692026736;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uVfa+QMd2zH/cfIHSNN0dnX9lPXFYxYQbQ4a91P5Z/s=;
        b=B+L7Y0EkALfivJzT3tpVTdT033crMCRRKgKQ9vKSL9vclzoCatBdBOnTdARzIpRUqt
         x6EN6/35O66J1l8YCjGD1409t+lV2GVhgzm67pQRozGp40vMyE5536bppoIjQtk245zf
         U5d23eeXlEHqAMPD6UttIIMZmLI+mMsLX+uM6TkTQ52fAHgQKqnf9C9DvLx/bb2kAr+F
         5DKKoiinBaKf8U/WpVazSmlFcYeIC1IGilR09tUpVmEUq6HRfdZjMyygGQczmQZBqKJV
         H5kV7L88WgBfF2HJFYJTZlULSX+QLEQ4Mby3pZdKMVB8rzaJic3a8Zlvoz05vTqdshD9
         x1HA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691421936; x=1692026736;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=uVfa+QMd2zH/cfIHSNN0dnX9lPXFYxYQbQ4a91P5Z/s=;
        b=cJ6K9XwyfmGnEUV61FtXGcyQaHlsWi8eKQ0HLeytJfCeKYPo0beWr1C/FTIF1udAeU
         U3ptR4DRnUee22wm95bhLxPSRDC+p8YzpSa+kwcAIkjhOExSlg89koOMjQu+MNagRpJO
         FTrY9bHQAI1s7N4WADcnM3uTgJon/bnyyehEz00x72QC3wTqU05cyqJMt6kNZlzIs0U6
         I/qZHOd8bhMEuF2AyxRjWF1U6xCFSkKq/tziERwoGvM4wx+67fyHLvuJXhnxvD0pIUpk
         5PoBe9OcqNzzQbXIewRMeYHhXt3lhC9Th2n+cHc4VDKNiiD6q540z6oxeYmtT+JKN/85
         vGJA==
X-Gm-Message-State: AOJu0YwnmhJS37Jm7NknAphdPtOCD6/ezaiuOEEn3uqvsuuUiRMCdBVD
        BKVg4XI6vLuWLBS7+wsEXKSJqh5n6GDw4XC7vBs=
X-Google-Smtp-Source: AGHT+IEAqEZmOBCFU0VrG42Vt0MG0ztXo19zmMkvdMSureqBPV+AW3lcYW6cZun2NT8YjUuLzgfrzh2F1NFMrR9Kwvg=
X-Received: by 2002:a05:6870:b155:b0:19f:2257:6865 with SMTP id
 a21-20020a056870b15500b0019f22576865mr9969932oal.31.1691421935724; Mon, 07
 Aug 2023 08:25:35 -0700 (PDT)
MIME-Version: 1.0
References: <20230807130108.853357011@linutronix.de> <20230807135026.698506626@linutronix.de>
In-Reply-To: <20230807135026.698506626@linutronix.de>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Mon, 7 Aug 2023 18:24:59 +0300
Message-ID: <CAHp75VeZic8KTj5x-OFMojWB2jn4tMq9eKSWm_MeJoaO5FQOGg@mail.gmail.com>
Subject: Re: [patch 05/53] x86/apic: Get rid of get_physical_broadcast()
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     LKML <linux-kernel@vger.kernel.org>, x86@kernel.org,
        Tom Lendacky <thomas.lendacky@amd.com>,
        Andrew Cooper <andrew.cooper3@citrix.com>,
        Arjan van de Ven <arjan@linux.intel.com>,
        Huang Rui <ray.huang@amd.com>, Juergen Gross <jgross@suse.com>,
        Dimitri Sivanich <dimitri.sivanich@hpe.com>,
        Michael Kelley <mikelley@microsoft.com>,
        Sohil Mehta <sohil.mehta@intel.com>,
        K Prateek Nayak <kprateek.nayak@amd.com>,
        Kan Liang <kan.liang@linux.intel.com>,
        Zhang Rui <rui.zhang@intel.com>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Feng Tang <feng.tang@intel.com>,
        Andy Shevchenko <andy@infradead.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 7, 2023 at 4:52=E2=80=AFPM Thomas Gleixner <tglx@linutronix.de>=
 wrote:
>
> There is no point for this function. The only case where this is used whe=
n

used is when

> there is no XAPIC available, which means the broadcast address is 0xF.

...

> +               if (mpc_ioapic_id(ioapic_idx) >=3D broadcast_id) {
> +                       pr_err("BIOS bug, IO-APIC#%d ID is %d in the MPC =
table!...\n",

Wouldn't it be better to switch to FW_BUG instead of the "BIOS bug,  " thin=
gy?
Same for other similar cases.

> +                              ioapic_idx, mpc_ioapic_id(ioapic_idx));
> +                       pr_err("... fixing up to %d. (tell your hw vendor=
)\n", reg_00.bits.ID);
>                         ioapics[ioapic_idx].mp_config.apicid =3D reg_00.b=
its.ID;
>                 }

...

> -       if ((boot_cpu_data.x86_vendor =3D=3D X86_VENDOR_INTEL) &&
> -           !APIC_XAPIC(boot_cpu_apic_version))
> +       if ((boot_cpu_data.x86_vendor =3D=3D X86_VENDOR_INTEL) && !APIC_X=
APIC(boot_cpu_apic_version))
>                 return io_apic_get_unique_id(idx, id);

>         else

You can also kill the redundant 'else'.

>                 return id;

--=20
With Best Regards,
Andy Shevchenko
