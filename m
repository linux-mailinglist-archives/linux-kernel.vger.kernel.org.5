Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 846757CE92A
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Oct 2023 22:39:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232625AbjJRUix (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Oct 2023 16:38:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59430 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232008AbjJRUiu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Oct 2023 16:38:50 -0400
Received: from mail-yw1-x1149.google.com (mail-yw1-x1149.google.com [IPv6:2607:f8b0:4864:20::1149])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 38563118
        for <linux-kernel@vger.kernel.org>; Wed, 18 Oct 2023 13:38:48 -0700 (PDT)
Received: by mail-yw1-x1149.google.com with SMTP id 00721157ae682-5a7af53bde4so117852397b3.0
        for <linux-kernel@vger.kernel.org>; Wed, 18 Oct 2023 13:38:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1697661527; x=1698266327; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=B2vuxwNUjHanOakE7PhkoyaYiDRMZoiUmEZlALcX3Sg=;
        b=l+i9Vriy0mKx1DFwNLR091rbBl7Gh06KudCc9JqdnPeE8KS9Ebsh3yPobluCA3KD74
         ejE2E2llS0Tr80hMVpEFqjah3b/WwZPhcSnPdRUdM9fjKIoBywLjkwfayb5prgOvxr4q
         SI/9TG+hgffXekwBH+vdO9YHlZXuOirNZt6tHDsxvZlogHY9lkSqjpqaWSuxFWBs4Ey9
         5YOn3NyYLchnZQdElAgeoDsfHA01EOfR//Pe1jfn5hcWQ4cO+WTbaDr+oJCjdqo9WAmI
         4PTbTBNBwqR3ym1WzvHAad9PrD9HMcycXgxuuivNS1WI7Ijb5GUy69cG4MX9PCuVDPeg
         F+FA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697661527; x=1698266327;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=B2vuxwNUjHanOakE7PhkoyaYiDRMZoiUmEZlALcX3Sg=;
        b=OGpeXJU+YEQKLni3xQ3ig0GQID9WXeaqaeO6G/i7YlN8s49M+po500fLhLjbpCZk+z
         Es584nshdcM0QHiXF7Ysf+G1qw7YppAfvAreI+wRVy0uzFIJxZ1eV99ai1bYvVlXUB3+
         O60qrZFRTRDoOYzowgLH92XH2Vb5KpseqvVKBOPG9xHtKR7sfk1JxPPzrgPdWig2Oxy1
         osGpSZPs/ST3xnicrNYmNVJXLwTiVw1H5N7RroLINpzBirujyQGvpUKAGnBRGmIhC5BW
         /WatWimUAolMVJz40Nx5aqHgNg81nUpGqSXQHECQjBBWfPmxJQd5gCkU/XPiFzo3FH6/
         YvIg==
X-Gm-Message-State: AOJu0YyIZid2ZV1U2opZQRpbM3E31106qeyxt9BD7d7acAPFw/EsVLaY
        IopxI07daVWceoofWwkfQr/IV2WF6XQ=
X-Google-Smtp-Source: AGHT+IGd6l8t7dSPqvjLwr1up5LbNppFyLB+KHswpcTN3MkRXf+fX3swfqUVEKJu/4yV2rYkq43dRov4EMo=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a0d:d5ca:0:b0:5a8:7b96:23d8 with SMTP id
 x193-20020a0dd5ca000000b005a87b9623d8mr9852ywd.3.1697661527331; Wed, 18 Oct
 2023 13:38:47 -0700 (PDT)
Date:   Wed, 18 Oct 2023 13:38:46 -0700
In-Reply-To: <09556ee3-3d9c-0ecc-0b4a-3df2d6bb5255@amd.com>
Mime-Version: 1.0
References: <20231016132819.1002933-1-michael.roth@amd.com>
 <20231016132819.1002933-49-michael.roth@amd.com> <CAAH4kHb=hNH88poYw-fj+ewYgt8F-hseZcRuLDdvbgpSQ5FDZQ@mail.gmail.com>
 <ZS614OSoritrE1d2@google.com> <b9da2fed-b527-4242-a588-7fc3ee6c9070@amd.com>
 <ZS_iS4UOgBbssp7Z@google.com> <09556ee3-3d9c-0ecc-0b4a-3df2d6bb5255@amd.com>
Message-ID: <ZTBCVpXaGcyFaozo@google.com>
Subject: Re: [PATCH v10 48/50] KVM: SEV: Provide support for SNP_GUEST_REQUEST
 NAE event
From:   Sean Christopherson <seanjc@google.com>
To:     Ashish Kalra <ashish.kalra@amd.com>
Cc:     Alexey Kardashevskiy <aik@amd.com>,
        Dionna Amalie Glaze <dionnaglaze@google.com>,
        Michael Roth <michael.roth@amd.com>, kvm@vger.kernel.org,
        linux-coco@lists.linux.dev, linux-mm@kvack.org,
        linux-crypto@vger.kernel.org, x86@kernel.org,
        linux-kernel@vger.kernel.org, tglx@linutronix.de, mingo@redhat.com,
        jroedel@suse.de, thomas.lendacky@amd.com, hpa@zytor.com,
        ardb@kernel.org, pbonzini@redhat.com, vkuznets@redhat.com,
        jmattson@google.com, luto@kernel.org, dave.hansen@linux.intel.com,
        slp@redhat.com, pgonda@google.com, peterz@infradead.org,
        srinivas.pandruvada@linux.intel.com, rientjes@google.com,
        dovmurik@linux.ibm.com, tobin@ibm.com, bp@alien8.de,
        vbabka@suse.cz, kirill@shutemov.name, ak@linux.intel.com,
        tony.luck@intel.com, marcorr@google.com,
        sathyanarayanan.kuppuswamy@linux.intel.com, alpergun@google.com,
        jarkko@kernel.org, nikunj.dadhania@amd.com, pankaj.gupta@amd.com,
        liam.merwick@oracle.com, zhi.a.wang@intel.com,
        Brijesh Singh <brijesh.singh@amd.com>
Content-Type: text/plain; charset="us-ascii"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 18, 2023, Ashish Kalra wrote:
> > static int snp_handle_ext_guest_request(struct vcpu_svm *svm)
> > {
> > 	struct kvm_vcpu *vcpu = &svm->vcpu;
> > 	struct kvm *kvm = vcpu->kvm;
> > 	struct kvm_sev_info *sev;
> > 	unsigned long exitcode;
> > 	u64 data_gpa;
> > 
> > 	if (!sev_snp_guest(vcpu->kvm)) {
> > 		ghcb_set_sw_exit_info_2(svm->sev_es.ghcb, SEV_RET_INVALID_GUEST);
> > 		return 1;
> > 	}
> > 
> > 	data_gpa = vcpu->arch.regs[VCPU_REGS_RAX];
> > 	if (!IS_ALIGNED(data_gpa, PAGE_SIZE)) {
> > 		ghcb_set_sw_exit_info_2(svm->sev_es.ghcb, SEV_RET_INVALID_ADDRESS);
> > 		return 1;
> > 	}
> > 
> > 	vcpu->run->hypercall.nr		 = KVM_HC_SNP_GET_CERTS;
> > 	vcpu->run->hypercall.args[0]	 = data_gpa;
> > 	vcpu->run->hypercall.args[1]	 = vcpu->arch.regs[VCPU_REGS_RBX];
> > 	vcpu->run->hypercall.flags	 = KVM_EXIT_HYPERCALL_LONG_MODE;
> > 	vcpu->arch.complete_userspace_io = snp_complete_ext_guest_request;
> > 	return 0;
> > }
> > 
> 
> IIRC, the important consideration here is to ensure that getting the
> attestation report and retrieving the certificates appears atomic to the
> guest. When SNP live migration is supported we don't want a case where the
> guest could have migrated between the call to obtain the certificates and
> obtaining the attestation report, which can potentially cause failure of
> validation of the attestation report.

Where does "obtaining the attestation report" happen?  I see the guest request
and the certificate stuff, I don't see anything about attestation reports (though
I'm not looking very closely).
