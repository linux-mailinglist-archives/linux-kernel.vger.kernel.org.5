Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9A54C77112B
	for <lists+linux-kernel@lfdr.de>; Sat,  5 Aug 2023 19:52:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229915AbjHERwW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 5 Aug 2023 13:52:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33932 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229500AbjHERwV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 5 Aug 2023 13:52:21 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 11D69DD;
        Sat,  5 Aug 2023 10:52:18 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 8141560D3E;
        Sat,  5 Aug 2023 17:52:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 11AF0C433C8;
        Sat,  5 Aug 2023 17:52:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1691257936;
        bh=7xuqFxXsqwxW46XcYfDKeVI6isB0kgq3V6jgMI/z7Rg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=WAXSR1ilIqO9m3q8cth50MwNGtoU/+ZE+aL5MP+k36ZLbDhSK8AN2yliT9Be2YHiS
         DhyhXG9lyjtJWygr01Zo49vJywEwp9ZBa5ZGWtZZGIVuMNrR1G2Bgy3CnTAYcU3iQT
         7Ir4/2y1XlI4GREub7/GHxGQzh34mKDJvk0sKeAXy2fP8L7HtwrOPMO4IClEbpyldT
         4KUPIG4hO34e7/RM2wbr1ILgRu5h4bLPyLu9Yn/DWa3zPNU7HFRLBgnUikSY7pIm5A
         wmsVvpuTQPMnu+Vpg1YoFKcW3WXnevS7SS5ETMkgXQvPQ6nuOI+ZDRsh7CV7YdpeqU
         O9oTxGytsdacw==
Date:   Sat, 5 Aug 2023 10:55:14 -0700
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
Subject: Re: [PATCH v14 10/25] gunyah: rsc_mgr: Add RPC for sharing memory
Message-ID: <wdjb4ycze3kqwsslrpqas2x4fwjoybpxklvrtklektsz3ymyd4@fenjxux4ab4x>
References: <20230613172054.3959700-1-quic_eberman@quicinc.com>
 <20230613172054.3959700-11-quic_eberman@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230613172054.3959700-11-quic_eberman@quicinc.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 13, 2023 at 10:20:38AM -0700, Elliot Berman wrote:
> Gunyah resource manager provides API to manipulate stage 2 page tables.
> Manipulations are represented as a memory parcel. Memory parcels
> describe a list of memory regions (intermediate physical address--IPA--and
> size), a list of new permissions for VMs, and the memory type (DDR or
> MMIO). Each memory parcel is uniquely identified by a handle allocated by
> Gunyah. There are a few types of memory parcel sharing which Gunyah
> supports:
> 
>  - Sharing: the guest and host VM both have access
>  - Lending: only the guest has access; host VM loses access
>  - Donating: Permanently lent (not reclaimed even if guest shuts down)
> 
> Memory parcels that have been shared or lent can be reclaimed by the
> host via an additional call. The reclaim operation restores the original
> access the host VM had to the memory parcel and removes the access to
> other VM.
> 
> One point to note that memory parcels don't describe where in the guest
> VM the memory parcel should reside. The guest VM must accept the memory
> parcel either explicitly via a "gh_rm_mem_accept" call (not introduced
> here) or be configured to accept it automatically at boot. When the guest
> VM accepts the memory parcel, it also mentions the IPA it wants to place
> memory parcel. Although the region might be discontiguous on the host,
> the memory parcel is place contiguously in the guest memory at the
> specified IPA.
> 
> Reviewed-by: Alex Elder <elder@linaro.org>
> Reviewed-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
> Co-developed-by: Prakruthi Deepak Heragu <quic_pheragu@quicinc.com>
> Signed-off-by: Prakruthi Deepak Heragu <quic_pheragu@quicinc.com>
> Signed-off-by: Elliot Berman <quic_eberman@quicinc.com>
> ---
>  drivers/virt/gunyah/rsc_mgr_rpc.c | 227 ++++++++++++++++++++++++++++++
>  include/linux/gunyah_rsc_mgr.h    |  48 +++++++
>  2 files changed, 275 insertions(+)
> 
> diff --git a/drivers/virt/gunyah/rsc_mgr_rpc.c b/drivers/virt/gunyah/rsc_mgr_rpc.c
> index a4a9f0ba4e1fc..25064123a31c3 100644
> --- a/drivers/virt/gunyah/rsc_mgr_rpc.c
> +++ b/drivers/virt/gunyah/rsc_mgr_rpc.c
> @@ -6,6 +6,12 @@
>  #include <linux/gunyah_rsc_mgr.h>
>  #include "rsc_mgr.h"
>  
> +/* Message IDs: Memory Management */
> +#define GH_RM_RPC_MEM_LEND			0x51000012
> +#define GH_RM_RPC_MEM_SHARE			0x51000013
> +#define GH_RM_RPC_MEM_RECLAIM			0x51000015
> +#define GH_RM_RPC_MEM_APPEND			0x51000018
> +
>  /* Message IDs: VM Management */
>  #define GH_RM_RPC_VM_ALLOC_VMID			0x56000001
>  #define GH_RM_RPC_VM_DEALLOC_VMID		0x56000002
> @@ -22,6 +28,46 @@ struct gh_rm_vm_common_vmid_req {
>  	__le16 _padding;
>  } __packed;
>  
> +/* Call: MEM_LEND, MEM_SHARE */
> +#define GH_MEM_SHARE_REQ_FLAGS_APPEND		BIT(1)
> +
> +struct gh_rm_mem_share_req_header {
> +	u8 mem_type;
> +	u8 _padding0;
> +	u8 flags;
> +	u8 _padding1;
> +	__le32 label;
> +} __packed;
> +
> +struct gh_rm_mem_share_req_acl_section {
> +	__le32 n_entries;
> +	struct gh_rm_mem_acl_entry entries[];
> +};
> +
> +struct gh_rm_mem_share_req_mem_section {
> +	__le16 n_entries;
> +	__le16 _padding;
> +	struct gh_rm_mem_entry entries[];
> +};

Any reason why these two are not explicitly packed?

> +
> +/* Call: MEM_RELEASE */
> +struct gh_rm_mem_release_req {
> +	__le32 mem_handle;
> +	u8 flags; /* currently not used */
> +	u8 _padding0;
> +	__le16 _padding1;
> +} __packed;
> +
> +/* Call: MEM_APPEND */
> +#define GH_MEM_APPEND_REQ_FLAGS_END		BIT(0)
> +
> +struct gh_rm_mem_append_req_header {
> +	__le32 mem_handle;
> +	u8 flags;
> +	u8 _padding0;
> +	__le16 _padding1;
> +} __packed;
> +
>  /* Call: VM_ALLOC */
>  struct gh_rm_vm_alloc_vmid_resp {
>  	__le16 vmid;
> @@ -51,6 +97,8 @@ struct gh_rm_vm_config_image_req {
>  	__le64 dtb_size;
>  } __packed;
>  
> +#define GH_RM_MAX_MEM_ENTRIES	512
> +
>  /*
>   * Several RM calls take only a VMID as a parameter and give only standard
>   * response back. Deduplicate boilerplate code by using this common call.
> @@ -64,6 +112,185 @@ static int gh_rm_common_vmid_call(struct gh_rm *rm, u32 message_id, u16 vmid)
>  	return gh_rm_call(rm, message_id, &req_payload, sizeof(req_payload), NULL, NULL);
>  }
>  
> +static int _gh_rm_mem_append(struct gh_rm *rm, u32 mem_handle, bool end_append,
> +			struct gh_rm_mem_entry *mem_entries, size_t n_mem_entries)
> +{
> +	struct gh_rm_mem_share_req_mem_section *mem_section;

"sections" is sufficient.

> +	struct gh_rm_mem_append_req_header *req_header;
> +	size_t msg_size = 0;
> +	void *msg;
> +	int ret;
> +
> +	msg_size += sizeof(struct gh_rm_mem_append_req_header);

msg_size is sizeof(header) + sizeof(sections), but written this way you
state that it's:

msg_size is X + sizeof(header),
and msg_size is also sizeof(sections)


It's the same thing, but you're forcing the reader to look for the
initial value of msg_size.

> +	msg_size += struct_size(mem_section, entries, n_mem_entries);
> +
> +	msg = kzalloc(msg_size, GFP_KERNEL);
> +	if (!msg)
> +		return -ENOMEM;
> +
> +	req_header = msg;

Can't you just make msg a strcut gh_rm_mem_append_req_header?

> +	mem_section = (void *)(req_header + 1);
> +
> +	req_header->mem_handle = cpu_to_le32(mem_handle);
> +	if (end_append)
> +		req_header->flags |= GH_MEM_APPEND_REQ_FLAGS_END;
> +
> +	mem_section->n_entries = cpu_to_le16(n_mem_entries);
> +	memcpy(mem_section->entries, mem_entries, sizeof(*mem_entries) * n_mem_entries);
> +
> +	ret = gh_rm_call(rm, GH_RM_RPC_MEM_APPEND, msg, msg_size, NULL, NULL);
> +	kfree(msg);
> +
> +	return ret;
> +}
> +
> +static int gh_rm_mem_append(struct gh_rm *rm, u32 mem_handle,
> +			struct gh_rm_mem_entry *mem_entries, size_t n_mem_entries)

You can name these arguments "entries" and "n_entries" (or num_entries)
without loosing any infromation, but saving a whole bunch of characters
that people have to read.

> +{
> +	bool end_append;

Iiuc this means "is this the last entry", perhaps calling it "last"
would make its purpose immediately obvious.

> +	int ret = 0;
> +	size_t n;
> +
> +	while (n_mem_entries) {
> +		if (n_mem_entries > GH_RM_MAX_MEM_ENTRIES) {
> +			end_append = false;
> +			n = GH_RM_MAX_MEM_ENTRIES;
> +		} else {
> +			end_append = true;
> +			n = n_mem_entries;
> +		}
> +
> +		ret = _gh_rm_mem_append(rm, mem_handle, end_append, mem_entries, n);

Every loop here you kzallc() and kfree() the same chunk of scratch
memory. If you inline _gh_rm_mem_append() here and do the allocation
once based on GH_RM_MAX_MEM_ENTRIES this would be faster and seemingly
easier to read/follow.

> +		if (ret)
> +			break;
> +
> +		mem_entries += n;
> +		n_mem_entries -= n;
> +	}
> +
> +	return ret;
> +}
> +
> +static int gh_rm_mem_lend_common(struct gh_rm *rm, u32 message_id, struct gh_rm_mem_parcel *p)
> +{
> +	size_t msg_size = 0, initial_mem_entries = p->n_mem_entries, resp_size;
> +	size_t acl_section_size, mem_section_size;

You keep all other variables one per line, and in reverse x-mas style.
Please do the same for this.

Naming these acl_size and mem_size would be beneficial.

> +	struct gh_rm_mem_share_req_acl_section *acl_section;
> +	struct gh_rm_mem_share_req_mem_section *mem_section;

Naming these acl and mem will make below easier to read.

> +	struct gh_rm_mem_share_req_header *req_header;
> +	u32 *attr_section;
> +	__le32 *resp;
> +	void *msg;
> +	int ret;
> +
> +	if (!p->acl_entries || !p->n_acl_entries || !p->mem_entries || !p->n_mem_entries ||
> +	    p->n_acl_entries > U8_MAX || p->mem_handle != GH_MEM_HANDLE_INVAL)
> +		return -EINVAL;
> +
> +	if (initial_mem_entries > GH_RM_MAX_MEM_ENTRIES)
> +		initial_mem_entries = GH_RM_MAX_MEM_ENTRIES;
> +
> +	acl_section_size = struct_size(acl_section, entries, p->n_acl_entries);
> +	mem_section_size = struct_size(mem_section, entries, initial_mem_entries);

An empty line here seems reasonable.

> +	/* The format of the message goes:
> +	 * request header
> +	 * ACL entries (which VMs get what kind of access to this memory parcel)
> +	 * Memory entries (list of memory regions to share)
> +	 * Memory attributes (currently unused, we'll hard-code the size to 0)
> +	 */
> +	msg_size += sizeof(struct gh_rm_mem_share_req_header);

Hidden above is the confirmation that msg_size was initialized to 0,
drop the '+' here to make it clear.

> +	msg_size += acl_section_size;
> +	msg_size += mem_section_size;
> +	msg_size += sizeof(u32); /* for memory attributes, currently unused */
> +
> +	msg = kzalloc(msg_size, GFP_KERNEL);
> +	if (!msg)
> +		return -ENOMEM;
> +
> +	req_header = msg;

I don't think you need to keep req_header and msg separately.

> +	acl_section = (void *)req_header + sizeof(*req_header);
> +	mem_section = (void *)acl_section + acl_section_size;
> +	attr_section = (void *)mem_section + mem_section_size;
> +
> +	req_header->mem_type = p->mem_type;
> +	if (initial_mem_entries != p->n_mem_entries)

I think this will only happen if p->n_mem_entries >
GH_RM_MAX_MEM_ENTRIES, for which you already have a condition earlier.
Set the flag in that condition rather than spreading it over two (three)
code paths.

> +		req_header->flags |= GH_MEM_SHARE_REQ_FLAGS_APPEND;
> +	req_header->label = cpu_to_le32(p->label);
> +
> +	acl_section->n_entries = cpu_to_le32(p->n_acl_entries);
> +	memcpy(acl_section->entries, p->acl_entries,
> +		flex_array_size(acl_section, entries, p->n_acl_entries));
> +
> +	mem_section->n_entries = cpu_to_le16(initial_mem_entries);
> +	memcpy(mem_section->entries, p->mem_entries,
> +		flex_array_size(mem_section, entries, initial_mem_entries));
> +
> +	/* Set n_entries for memory attribute section to 0 */
> +	*attr_section = 0;
> +
> +	ret = gh_rm_call(rm, message_id, msg, msg_size, (void **)&resp, &resp_size);
> +	kfree(msg);
> +
> +	if (ret)
> +		return ret;
> +
> +	p->mem_handle = le32_to_cpu(*resp);
> +	kfree(resp);
> +
> +	if (initial_mem_entries != p->n_mem_entries) {

Another "we took that conditional path above", please make it obvious.


Can you please also write a comment describing that this operation is
split in a main one, followed by one of more appended operations as
necessary. This took me too long time to realize...

In particular I was wondering why "initial" didn't mean "the original
value", but now I see that it probably means "the value relevant for the
initial request".

> +		ret = gh_rm_mem_append(rm, p->mem_handle,
> +					&p->mem_entries[initial_mem_entries],
> +					p->n_mem_entries - initial_mem_entries);
> +		if (ret) {
> +			gh_rm_mem_reclaim(rm, p);
> +			p->mem_handle = GH_MEM_HANDLE_INVAL;

What happens to the entries that was already lended or shared?

Regards,
Bjorn
