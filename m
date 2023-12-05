Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D6332805C2F
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Dec 2023 18:50:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231932AbjLEQ5e (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Dec 2023 11:57:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55356 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345170AbjLEQ5a (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Dec 2023 11:57:30 -0500
Received: from mail-yw1-x114a.google.com (mail-yw1-x114a.google.com [IPv6:2607:f8b0:4864:20::114a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 884A3188
        for <linux-kernel@vger.kernel.org>; Tue,  5 Dec 2023 08:57:36 -0800 (PST)
Received: by mail-yw1-x114a.google.com with SMTP id 00721157ae682-5ca2a6f07b6so94918797b3.2
        for <linux-kernel@vger.kernel.org>; Tue, 05 Dec 2023 08:57:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1701795455; x=1702400255; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=jK7s+QAqQUTPUwpooiy5GVM6IbU9OMdsdVHDH5OFNq4=;
        b=aOevY/Qe7zUcXkFFuv4sbeDRgX2s2dMIMYU38YRJMA3jSFDQfypw3w+KH5AlPPUv0w
         D8dt/0bTkQXcn1gfG1mEK61F0x5t9vHyDj5+V51NPzmoaCYUhvsSbRy7MLjVG++p5/tU
         p4BABMJSdN2GtIHBBHI/68XeG/e2jjGk6xi8Qmqma7Mvd2sEDs/QUv3TMS6G5Db28pNo
         YDAsya+vzspvw2FdeMQoEo0CXiT9fCxXckkRa7ou5gpkeJdlaSi+XaDOwXcL7rfFqS1C
         tA8inX0axpPuuR+cMZx7ojqdvmCVi9oAbPFNg5YSY3IToePjS1v37mj8QOoPTe5UiyjV
         CKXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701795455; x=1702400255;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=jK7s+QAqQUTPUwpooiy5GVM6IbU9OMdsdVHDH5OFNq4=;
        b=XPzu+u+5Nw01cm275gnFrW2aH0dQhX/A3Vagkfvj8egMpmkQp+dS17KEsAIABrHz5M
         FdyyQDtclaw841qEj1x3FnyuQNdW6NOw3SkXTTkrTM661ySEoDcNAxkiFRdkdHWrEh8V
         UzzoVoG2mAokECqiN1NUUcXkHnVQPdFxGmqcCBA3xozijs/SPwV9g8lrn2t1zsBDCeM2
         d37xWC2b6+nSqLLYAvmgse6X7Upzo21n3ivcQ7vkp4MlgtvY3cRqHudb7zQbmE4FlvBY
         k4f6jEh14YX7HpZzWZH85xVTiNOLsVZaon1A63kUIHqAR2/KnK0JwmPslyZ+8jO/gf84
         /+ug==
X-Gm-Message-State: AOJu0Yy2GodtsJ0yvmyylTUA9430S5QTeYAtiPLiYbbv17A/GBbm3suG
        nRxksS0EIcIjnPkgWjLOWdVOwcTzMCg=
X-Google-Smtp-Source: AGHT+IFNCZti+PtUeZbrU9k1NsaHVuTOlCh5gYjHVW73ZX9BwSndogpBysvCVDd/UehToxHvmP0NS9TQa3s=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a81:9bd6:0:b0:5d3:8857:b78e with SMTP id
 s205-20020a819bd6000000b005d38857b78emr418668ywg.10.1701795455593; Tue, 05
 Dec 2023 08:57:35 -0800 (PST)
Date:   Tue, 5 Dec 2023 08:57:33 -0800
In-Reply-To: <DS7PR11MB60774E0BC0F8EFA103310D27FC85A@DS7PR11MB6077.namprd11.prod.outlook.com>
Mime-Version: 1.0
References: <9e80873fac878aa5d697cbcd4d456d01e1009d1f.1699527082.git.kai.huang@intel.com>
 <b3b265f9-48fa-4574-a925-cbdaaa44a689@intel.com> <afc875ace6f9f955557f5c7e811b3046278e4c51.camel@intel.com>
 <bcff605a-3b8d-4dcc-a5cb-63dab1a74ed4@intel.com> <dfbfe327704f65575219d8b895cf9f55985758da.camel@intel.com>
 <9b221937-42df-4381-b79f-05fb41155f7a@intel.com> <c12073937fcca2c2e72f9964675ef4ac5dddb6fb.camel@intel.com>
 <1a5b18b2-3072-46d9-9d44-38589cb54e40@intel.com> <ZW6FRBnOwYV-UCkY@google.com>
 <DS7PR11MB60774E0BC0F8EFA103310D27FC85A@DS7PR11MB6077.namprd11.prod.outlook.com>
Message-ID: <ZW9WfR5Wlk3dgNvy@google.com>
Subject: Re: [PATCH v15 22/23] x86/mce: Improve error log of kernel space TDX
 #MC due to erratum
From:   Sean Christopherson <seanjc@google.com>
To:     Tony Luck <tony.luck@intel.com>
Cc:     Dave Hansen <dave.hansen@intel.com>,
        Kai Huang <kai.huang@intel.com>,
        "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "rafael@kernel.org" <rafael@kernel.org>,
        Chao Gao <chao.gao@intel.com>,
        "david@redhat.com" <david@redhat.com>,
        "bagasdotme@gmail.com" <bagasdotme@gmail.com>,
        "ak@linux.intel.com" <ak@linux.intel.com>,
        "kirill.shutemov@linux.intel.com" <kirill.shutemov@linux.intel.com>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "pbonzini@redhat.com" <pbonzini@redhat.com>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        Isaku Yamahata <isaku.yamahata@intel.com>,
        "nik.borisov@suse.com" <nik.borisov@suse.com>,
        "hpa@zytor.com" <hpa@zytor.com>,
        "sagis@google.com" <sagis@google.com>,
        "imammedo@redhat.com" <imammedo@redhat.com>,
        "peterz@infradead.org" <peterz@infradead.org>,
        "bp@alien8.de" <bp@alien8.de>, Len Brown <len.brown@intel.com>,
        "sathyanarayanan.kuppuswamy@linux.intel.com" 
        <sathyanarayanan.kuppuswamy@linux.intel.com>,
        Ying Huang <ying.huang@intel.com>,
        Dan J Williams <dan.j.williams@intel.com>,
        "x86@kernel.org" <x86@kernel.org>
Content-Type: text/plain; charset="us-ascii"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 05, 2023, Tony Luck wrote:
> >> Fine.  This doesn't need to change ... until you load TDX.  Once you
> >> initialize the TDX module, no more out-of-tree VMMs for you.
> >
> > It's not just out-of-tree hypervisors, which IMO should be little more than an
> > afterthought.  The other more important issue is that being post-VMXON blocks INIT,
> 
> Does that make CPU offline a one-way process? Linux uses INIT to bring a CPU back
> online again.

No, KVM does VMXOFF on the CPU being offlined, and then VMXON if/when the CPU is
onlined again.  This also handles secondary CPUs for suspend/resume (the primary
CPU hooks .suspend() and .resume()).

static int kvm_offline_cpu(unsigned int cpu)
{
	mutex_lock(&kvm_lock);
	if (kvm_usage_count)
		hardware_disable_nolock(NULL);
	mutex_unlock(&kvm_lock);
	return 0;
}


static int kvm_online_cpu(unsigned int cpu)
{
	int ret = 0;

	/*
	 * Abort the CPU online process if hardware virtualization cannot
	 * be enabled. Otherwise running VMs would encounter unrecoverable
	 * errors when scheduled to this CPU.
	 */
	mutex_lock(&kvm_lock);
	if (kvm_usage_count)
		ret = __hardware_enable_nolock();
	mutex_unlock(&kvm_lock);
	return ret;
}
