Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7BCA97710D6
	for <lists+linux-kernel@lfdr.de>; Sat,  5 Aug 2023 19:15:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230060AbjHERPl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 5 Aug 2023 13:15:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50256 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230039AbjHERPi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 5 Aug 2023 13:15:38 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 42CA04213;
        Sat,  5 Aug 2023 10:15:37 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id CFD9060A4A;
        Sat,  5 Aug 2023 17:15:36 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 80588C433C7;
        Sat,  5 Aug 2023 17:15:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1691255736;
        bh=9ou0CUnVtcVMzJBkU+Fp+mCQ79SfaW351x3PsQOF0LM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=shUF1nviz6/7KhR0sHe28AClk0EbyoCdQfjWBu+KJsWhQicjsmLfr5FS71YAv0C+k
         AQGaB1Vtmx9EZ5TY5pdNMiAG1AFc5vl0AJ9BBd5M6Ktgler2jave6sumeoJ9YHWHby
         pSodZX5qN8K5377LOd+U5+tbmL0p3B09gFW6SIL1yvBxz1+wbJ2KSBq5TNQfSKVRQe
         JSKy+aUjX+E6fcWJ4Zy4VqNtZg7W1CwzO3k6mBcosvQX3+lOCKnrOeify5FCBlZQW1
         JPXXVXiXsCTUAXNkD1MenizLYT3OJ241bMOMVBsfMCKdCgUHQMNoGxDMLPTKSdQvZ8
         g+mKsawq4ZXFQ==
Date:   Sat, 5 Aug 2023 10:18:33 -0700
From:   Bjorn Andersson <andersson@kernel.org>
To:     Elliot Berman <quic_eberman@quicinc.com>
Cc:     Alex Elder <elder@linaro.org>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Prakruthi Deepak Heragu <quic_pheragu@quicinc.com>,
        Murali Nalajala <quic_mnalajal@quicinc.com>,
        Trilok Soni <quic_tsoni@quicinc.com>,
        Srivatsa Vaddagiri <quic_svaddagi@quicinc.com>,
        Carl van Schaik <quic_cvanscha@quicinc.com>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        Will Deacon <will@kernel.org>, Andy Gross <agross@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Jassi Brar <jassisinghbrar@gmail.com>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v14 08/25] gunyah: rsc_mgr: Add VM lifecycle RPC
Message-ID: <73qfofpl77uvppp6cag6hu2fesiiaoo2dp7y7see6ohfhzyymt@mwuhjrh2wvj5>
References: <20230613172054.3959700-1-quic_eberman@quicinc.com>
 <20230613172054.3959700-9-quic_eberman@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230613172054.3959700-9-quic_eberman@quicinc.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 13, 2023 at 10:20:36AM -0700, Elliot Berman wrote:
> diff --git a/drivers/virt/gunyah/rsc_mgr_rpc.c b/drivers/virt/gunyah/rsc_mgr_rpc.c
[..]
> +/**
> + * gh_rm_alloc_vmid() - Allocate a new VM in Gunyah. Returns the VM identifier.
> + * @rm: Handle to a Gunyah resource manager
> + * @vmid: Use 0 to dynamically allocate a VM. A reserved VMID can be supplied
> + *        to request allocation of a platform-defined VM.
> + *
> + * Returns - the allocated VMID or negative value on error

kernel-doc Return:

> + */
> +int gh_rm_alloc_vmid(struct gh_rm *rm, u16 vmid)
> +{
> +	struct gh_rm_vm_common_vmid_req req_payload = {
> +		.vmid = cpu_to_le16(vmid),
> +	};
> +	struct gh_rm_vm_alloc_vmid_resp *resp_payload;
> +	size_t resp_size;
> +	void *resp;
> +	int ret;
> +
> +	ret = gh_rm_call(rm, GH_RM_RPC_VM_ALLOC_VMID, &req_payload, sizeof(req_payload), &resp,

Wrap lines at 80 characters, unless it improves readability, which is
doesn't here as you wrap it later anyways.

(The gh_rm_call() in gh_rm_common_vmid_call() above is a good example of
where going above 80 characters looks good)

> +			&resp_size);
> +	if (ret)
> +		return ret;
> +
> +	if (!vmid) {
> +		resp_payload = resp;
> +		ret = le16_to_cpu(resp_payload->vmid);
> +		kfree(resp);
> +	}

With vmid specified, will the call somehow not return a response buffer?
If this is the case please document it here with a comment.

Otherwise, you're leaking resp.

> +
> +	return ret;
> +}
> +
> +/**
> + * gh_rm_dealloc_vmid() - Dispose of a VMID
> + * @rm: Handle to a Gunyah resource manager
> + * @vmid: VM identifier allocated with gh_rm_alloc_vmid

Doesn't hurt to define the return value of all these apis.

> + */
> +int gh_rm_dealloc_vmid(struct gh_rm *rm, u16 vmid)
> +{
> +	return gh_rm_common_vmid_call(rm, GH_RM_RPC_VM_DEALLOC_VMID, vmid);
> +}
> +
> +/**
> + * gh_rm_vm_reset() - Reset a VM's resources
> + * @rm: Handle to a Gunyah resource manager
> + * @vmid: VM identifier allocated with gh_rm_alloc_vmid
> + *
> + * As part of tearing down the VM, request RM to clean up all the VM resources
> + * associated with the VM. Only after this, Linux can clean up all the

s/, Linux can/can Linux/

> + * references it maintains to resources.
> + */
> +int gh_rm_vm_reset(struct gh_rm *rm, u16 vmid)
> +{
> +	return gh_rm_common_vmid_call(rm, GH_RM_RPC_VM_RESET, vmid);
> +}
[..]
> +int gh_rm_get_hyp_resources(struct gh_rm *rm, u16 vmid,
> +				struct gh_rm_hyp_resources **resources)
> +{
> +	struct gh_rm_vm_common_vmid_req req_payload = {
> +		.vmid = cpu_to_le16(vmid),
> +	};
> +	struct gh_rm_hyp_resources *resp;
> +	size_t resp_size;
> +	int ret;
> +
> +	ret = gh_rm_call(rm, GH_RM_RPC_VM_GET_HYP_RESOURCES,
> +			 &req_payload, sizeof(req_payload),
> +			 (void **)&resp, &resp_size);
> +	if (ret)
> +		return ret;
> +
> +	if (!resp_size)
> +		return -EBADMSG;
> +
> +	if (resp_size < struct_size(resp, entries, 0) ||
> +		resp_size != struct_size(resp, entries, le32_to_cpu(resp->n_entries))) {

Indent wrapped expressions to match the previous start of that
expression.

> +		kfree(resp);
> +		return -EBADMSG;
> +	}
> +
> +	*resources = resp;
> +	return 0;
> +}
> +
> +/**
> + * gh_rm_get_vmid() - Retrieve VMID of this virtual machine
> + * @rm: Handle to a Gunyah resource manager
> + * @vmid: Filled with the VMID of this VM

In gh_rm_alloc_vmid() you return the vmid (or a errno), here you return
the value by reference. Pick one please. (Preferably return vmid)

> + */
> +int gh_rm_get_vmid(struct gh_rm *rm, u16 *vmid)
> +{
> +	static u16 cached_vmid = GH_VMID_INVAL;
> +	size_t resp_size;
> +	__le32 *resp;
> +	int ret;
> +
> +	if (cached_vmid != GH_VMID_INVAL) {
> +		*vmid = cached_vmid;
> +		return 0;
> +	}

Regards,
Bjorn
