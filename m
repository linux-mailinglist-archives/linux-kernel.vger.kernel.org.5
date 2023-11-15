Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1BDB77EC391
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Nov 2023 14:27:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343793AbjKON1Q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Nov 2023 08:27:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36778 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343686AbjKON1P (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Nov 2023 08:27:15 -0500
Received: from mail-pf1-x449.google.com (mail-pf1-x449.google.com [IPv6:2607:f8b0:4864:20::449])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 51CEEA6
        for <linux-kernel@vger.kernel.org>; Wed, 15 Nov 2023 05:27:12 -0800 (PST)
Received: by mail-pf1-x449.google.com with SMTP id d2e1a72fcca58-6c7c6ae381fso2356591b3a.2
        for <linux-kernel@vger.kernel.org>; Wed, 15 Nov 2023 05:27:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1700054832; x=1700659632; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=67VCtaGV/e+lwlaWVR9CnUK5q5agNeqRm+nDDRKAEZQ=;
        b=a/oJLhc+8u1hy/keGxA5NPp0JULrhJVoRy1ikQCIK6eSYcCg0NLr1oG4tmnt973Wop
         sZ9SxAfwO6j03IV26rt0JeLRUyERcA0/8VVr8ca2Us12xd6rUzCjmHWlljMPbLxJUWgP
         PNmg4cKhkMoSbBD5SOgNutWOcMVDINCUg+Pd/MGoyeXmiV0ISo+xyI7f5KwrILT5nBvG
         eMRZE1SHurgbvnkMrRFco0Q2bgTvg8zxJIZ4o9MUY3aqZXEzDm29mEx3bYj2o6E3PZae
         1zVNauyCXIUHZCWt7TaVijMdwGcw+WrgTFYFEdREmB5SdUdZmvST0/iPO84BAY7d2r+i
         umDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700054832; x=1700659632;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=67VCtaGV/e+lwlaWVR9CnUK5q5agNeqRm+nDDRKAEZQ=;
        b=dn+Q9EbtUM95pYyF/WKEb9FaRHVpmt1AmtJbFx+WSVSQTFu6TkvoPt70/I6gBsbo93
         rxhJh2vYUQPgjwwH4RgYHSx1NPbKFB8MhWJpNPb/hOztS2WzjTzNNiYBWRSRgTqe7t7K
         0c5/WBuQfVVuSOk3jD8HzqQbr6gQb3+oYJMTUKlMy6IWPsKcX1CwMRn5R7lPbGQmK5Zy
         zWxc1H2/S9wKDr2CzxX++1ALWaSt3Fi+Fx+tNlbmE7i6ngjh7TsEoB/ZFQI71OKa44Go
         bgKRAQi7iHOohTPjX4ysRlewCJuvEJfAEsSu8BJGbutp+SC/016tRIWvKIO0WfMHiYhl
         +wIg==
X-Gm-Message-State: AOJu0YxC4eO8Xt9oXYnwzHD0tdyW8PtNY1fM6V6Q/2guGB5YtCGMglsv
        veFnYmvqsrshLbVsk+DV5N+cDSLylYQ=
X-Google-Smtp-Source: AGHT+IGQR9cTjt05emGJhEyHPqzcgKgeZVrV7cmq3OqY3waoSr8ME/Sjqg2R+aGyNwoMMrIHA0Zvr8M1Dm0=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a05:6a00:8b83:b0:6c0:ec5b:bb2d with SMTP id
 ig3-20020a056a008b8300b006c0ec5bbb2dmr3053306pfb.2.1700054831789; Wed, 15 Nov
 2023 05:27:11 -0800 (PST)
Date:   Wed, 15 Nov 2023 05:27:10 -0800
In-Reply-To: <d377806e-43af-4ac7-8e7a-291fb19a2091@intel.com>
Mime-Version: 1.0
References: <20230914063325.85503-1-weijiang.yang@intel.com>
 <20230914063325.85503-25-weijiang.yang@intel.com> <ZUHSTEGpdWGjL93M@chao-email>
 <d377806e-43af-4ac7-8e7a-291fb19a2091@intel.com>
Message-ID: <ZVTGlLYViK07rE55@google.com>
Subject: Re: [PATCH v6 24/25] KVM: nVMX: Introduce new VMX_BASIC bit for event
 error_code delivery to L1
From:   Sean Christopherson <seanjc@google.com>
To:     Weijiang Yang <weijiang.yang@intel.com>
Cc:     Chao Gao <chao.gao@intel.com>, pbonzini@redhat.com,
        kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
        dave.hansen@intel.com, peterz@infradead.org,
        rick.p.edgecombe@intel.com, john.allen@amd.com
Content-Type: text/plain; charset="us-ascii"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        USER_IN_DEF_DKIM_WL autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 15, 2023, Weijiang Yang wrote:
> On 11/1/2023 12:21 PM, Chao Gao wrote:
> > On Thu, Sep 14, 2023 at 02:33:24AM -0400, Yang Weijiang wrote:
> > > @@ -2846,12 +2846,16 @@ static int nested_check_vm_entry_controls(struct kvm_vcpu *vcpu,
> > > 		    CC(intr_type == INTR_TYPE_OTHER_EVENT && vector != 0))
> > > 			return -EINVAL;
> > > 
> > > -		/* VM-entry interruption-info field: deliver error code */
> > > -		should_have_error_code =
> > > -			intr_type == INTR_TYPE_HARD_EXCEPTION && prot_mode &&
> > > -			x86_exception_has_error_code(vector);
> > > -		if (CC(has_error_code != should_have_error_code))
> > > -			return -EINVAL;
> > > +		if (!prot_mode || intr_type != INTR_TYPE_HARD_EXCEPTION ||
> > > +		    !nested_cpu_has_no_hw_errcode_cc(vcpu)) {
> > > +			/* VM-entry interruption-info field: deliver error code */
> > > +			should_have_error_code =
> > > +				intr_type == INTR_TYPE_HARD_EXCEPTION &&
> > > +				prot_mode &&
> > > +				x86_exception_has_error_code(vector);
> > > +			if (CC(has_error_code != should_have_error_code))
> > > +				return -EINVAL;
> > > +		}
> > prot_mode and intr_type are used twice, making the code a little hard to read.
> > 
> > how about:
> > 		/*
> > 		 * Cannot deliver error code in real mode or if the
> > 		 * interruption type is not hardware exception. For other
> > 		 * cases, do the consistency check only if the vCPU doesn't
> > 		 * enumerate VMX_BASIC_NO_HW_ERROR_CODE_CC.
> > 		 */
> > 		if (!prot_mode || intr_type != INTR_TYPE_HARD_EXCEPTION) {
> > 			if (CC(has_error_code))
> > 				return -EINVAL;
> > 		} else if (!nested_cpu_has_no_hw_errcode_cc(vcpu)) {
> > 			if (CC(has_error_code != x86_exception_has_error_code(vector)))
> > 				return -EINVAL;
> > 		}

Or maybe go one step further and put the nested_cpu_has...() check inside the CC()
macro so that it too will be captured on error.  It's a little uglier though, and
I doubt providing that extra information will matter in practice, so definitely
feel free to stick with Chao's version.

		if (!prot_mode || intr_type != INTR_TYPE_HARD_EXCEPTION) {
			if (CC(has_error_code))
				return -EINVAL;
		} else if (CC(!nested_cpu_has_no_hw_errcode_cc(vcpu) &&
			      has_error_code != x86_exception_has_error_code(vector))) {
			return -EINVAL;
		}
