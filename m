Return-Path: <linux-kernel+bounces-108033-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 67FB988050B
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Mar 2024 19:44:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EB3671F23B15
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Mar 2024 18:44:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4DDC539FC6;
	Tue, 19 Mar 2024 18:44:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=embeddedor.com header.i=@embeddedor.com header.b="ohl1YzCB"
Received: from omta040.useast.a.cloudfilter.net (omta040.useast.a.cloudfilter.net [44.202.169.39])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4C2239FC9
	for <linux-kernel@vger.kernel.org>; Tue, 19 Mar 2024 18:44:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=44.202.169.39
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710873857; cv=none; b=FZH3/MfQDWSKTp0nuZqGi4yGDswzCIzbbFoj0yi0pQDZjjLlpAKx09mg0NSbJJ4OYbvdD5RAeQJdlkhHhqq+6cf6LxQ01ovOhwProtPAD/uaTL+wzDCZU4Fvlwxg2PUy9Vqe41LOW9A+PPA/9kyx+G/1mzr8zjKQYvMqMUZG8Qc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710873857; c=relaxed/simple;
	bh=iYAowg/p3SZt/jzyDoICds4PpBwrKLStcTMZ4bVn/rI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=dYy9YU8y6jKTHyTBQt4k+rD3kgTw0ic5TJ6pO20pnV/G4lPL4MtBIile6kUre2jlT0BwcowZEDDlqR9HWOdlY9Qu3PxJft+lfoH7uYVKyul6e2TJH3vEzFDaQG/fI1OaJfjuTsCXkvb6wtVf6GTnkbEBQFdHsS8obIhbFuGmb8E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=embeddedor.com; spf=pass smtp.mailfrom=embeddedor.com; dkim=pass (2048-bit key) header.d=embeddedor.com header.i=@embeddedor.com header.b=ohl1YzCB; arc=none smtp.client-ip=44.202.169.39
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=embeddedor.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=embeddedor.com
Received: from eig-obgw-6007a.ext.cloudfilter.net ([10.0.30.247])
	by cmsmtp with ESMTPS
	id md74rTynAl9dRmeRZrLGIA; Tue, 19 Mar 2024 18:44:14 +0000
Received: from gator4166.hostgator.com ([108.167.133.22])
	by cmsmtp with ESMTPS
	id meRYrkMcwVdenmeRZrfErw; Tue, 19 Mar 2024 18:44:13 +0000
X-Authority-Analysis: v=2.4 cv=M4FLKTws c=1 sm=1 tr=0 ts=65f9dcfd
 a=1YbLdUo/zbTtOZ3uB5T3HA==:117 a=UtBFqMlDG83dypD0sxEoAQ==:17
 a=IkcTkHD0fZMA:10 a=K6JAEmCyrfEA:10 a=wYkD_t78qR0A:10 a=VwQbUJbxAAAA:8
 a=d3QQw60kZKcH4I2Fy2IA:9 a=QEXdDO2ut3YA:10 a=AjGcO6oz07-iQ99wixmX:22
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=embeddedor.com; s=default; h=Content-Transfer-Encoding:Content-Type:
	In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
	List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=ydgYrx4mSNkCluaznyOIwLt873FVEZ38n23EhvbjbYg=; b=ohl1YzCBoSgJM3bZqMkwrinrCd
	TJXoN2aGs/7ypt907+FfzadI8+O7PJK1DUjo32eRE5j4xShV0YLhFmYCoTfmBqDer5Sg1NmL3wm3M
	NpXy383Y4hxJSnhzn3rzVIgdCOZAMuj4gTGkoIqp7EU4lJ6DMkimyA3QXrsvHSysto2jtd9zAKDcz
	aPxOlGudB99Mg7MenOEkXy4fJPqa2uj1r7PK3vWT9YyBsre+ffHApCf2mRkiv6riMCmk7goCqISq8
	fVZSPJS4FSrYsTjxcQPQVz9MfhnbCmnXaXOKvXFvG23FFYrgWdpnqOG2UWrGySG8KN63Mo5ps1UYB
	llvAOYTQ==;
Received: from [201.172.174.229] (port=46584 helo=[192.168.15.10])
	by gator4166.hostgator.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
	(Exim 4.96.2)
	(envelope-from <gustavo@embeddedor.com>)
	id 1rmeRW-00047P-3C;
	Tue, 19 Mar 2024 13:44:11 -0500
Message-ID: <626c234a-64ab-4449-a6d8-faeb24dd0abf@embeddedor.com>
Date: Tue, 19 Mar 2024 12:44:09 -0600
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH][next] integrity: Avoid -Wflex-array-member-not-at-end
 warnings
Content-Language: en-US
To: "Gustavo A. R. Silva" <gustavoars@kernel.org>,
 Mimi Zohar <zohar@linux.ibm.com>, Roberto Sassu <roberto.sassu@huawei.com>,
 Dmitry Kasatkin <dmitry.kasatkin@gmail.com>,
 Eric Snowberg <eric.snowberg@oracle.com>, Paul Moore <paul@paul-moore.com>,
 James Morris <jmorris@namei.org>, "Serge E. Hallyn" <serge@hallyn.com>
Cc: linux-integrity@vger.kernel.org, linux-security-module@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org,
 Kees Cook <keescook@chromium.org>
References: <ZeYKWrXvACBBrAP8@neat>
From: "Gustavo A. R. Silva" <gustavo@embeddedor.com>
In-Reply-To: <ZeYKWrXvACBBrAP8@neat>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - gator4166.hostgator.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - embeddedor.com
X-BWhitelist: no
X-Source-IP: 201.172.174.229
X-Source-L: No
X-Exim-ID: 1rmeRW-00047P-3C
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: ([192.168.15.10]) [201.172.174.229]:46584
X-Source-Auth: gustavo@embeddedor.com
X-Email-Count: 3
X-Org: HG=hgshared;ORG=hostgator;
X-Source-Cap: Z3V6aWRpbmU7Z3V6aWRpbmU7Z2F0b3I0MTY2Lmhvc3RnYXRvci5jb20=
X-Local-Domain: yes
X-CMAE-Envelope: MS4xfIu6P4J/cCaMRuZr9mbAlEpzi+iADPxDgJJTTAS6pHwF40SVrYzqEgzNfjwRYtThXLyZHWNnDV3G87KlpJGSnOw5E4zzXcA9kBJ5tn1RDIuvFZOscXek
 XLJeLRTIXqjOSf0TUXlx0hs6C80Fz4TWp+egJ/DYC8+IVDqqOF5Jw4Ki5PonsXnYRi/k60ZVQLRw7890Hcz+k4Ikdp4ORTYw8iz9AOqLB7atUXxfbd48Fcxc

Hi all,

Friendly ping: who can take this, please? :)

Thanks!
--
Gustavo

On 3/4/24 11:52, Gustavo A. R. Silva wrote:
> -Wflex-array-member-not-at-end is coming in GCC-14, and we are getting
> ready to enable it globally.
> 
> There is currently an object (`hdr)` in `struct ima_max_digest_data`
> that contains a flexible structure (`struct ima_digest_data`):
> 
>   struct ima_max_digest_data {
> 	struct ima_digest_data hdr;
>          u8 digest[HASH_MAX_DIGESTSIZE];
>   } __packed;
> 
> So, in order to avoid ending up with a flexible-array member in the
> middle of another struct, we use the `struct_group_tagged()` helper to
> separate the flexible array from the rest of the members in the flexible
> structure:
> 
> struct ima_digest_data {
>          struct_group_tagged(ima_digest_data_hdr, hdr,
> 
> 	... the rest of the members
> 
>          );
>          u8 digest[];
> } __packed;
> 
> With the change described above, we can now declare an object of the
> type of the tagged struct, without embedding the flexible array in the
> middle of another struct:
> 
>   struct ima_max_digest_data {
>          struct ima_digest_data_hdr hdr;
>          u8 digest[HASH_MAX_DIGESTSIZE];
>   } __packed;
> 
> We also use `container_of()` whenever we need to retrieve a pointer to
> the flexible structure.
> 
> So, with these changes, fix the following warnings:
> 
> security/integrity/evm/evm.h:45:32: warning: structure containing a flexible array member is not at the end of another structure [-Wflex-array-member-not-at-end]
> security/integrity/evm/evm.h:45:32: warning: structure containing a flexible array member is not at the end of another structure [-Wflex-array-member-not-at-end]
> security/integrity/evm/evm.h:45:32: warning: structure containing a flexible array member is not at the end of another structure [-Wflex-array-member-not-at-end]
> 
> Signed-off-by: Gustavo A. R. Silva <gustavoars@kernel.org>
> ---
>   security/integrity/ima/ima_api.c          |  6 ++++--
>   security/integrity/ima/ima_appraise.c     |  4 +++-
>   security/integrity/ima/ima_init.c         |  6 ++++--
>   security/integrity/ima/ima_main.c         |  6 ++++--
>   security/integrity/ima/ima_template_lib.c | 10 ++++++----
>   security/integrity/integrity.h            |  4 +++-
>   6 files changed, 24 insertions(+), 12 deletions(-)
> 
> diff --git a/security/integrity/ima/ima_api.c b/security/integrity/ima/ima_api.c
> index b37d043d5748..c7c8d1bffb17 100644
> --- a/security/integrity/ima/ima_api.c
> +++ b/security/integrity/ima/ima_api.c
> @@ -247,6 +247,8 @@ int ima_collect_measurement(struct ima_iint_cache *iint, struct file *file,
>   	struct inode *real_inode = d_real_inode(file_dentry(file));
>   	const char *filename = file->f_path.dentry->d_name.name;
>   	struct ima_max_digest_data hash;
> +	struct ima_digest_data *hash_hdr = container_of(&hash.hdr,
> +						struct ima_digest_data, hdr);
>   	struct kstat stat;
>   	int result = 0;
>   	int length;
> @@ -286,9 +288,9 @@ int ima_collect_measurement(struct ima_iint_cache *iint, struct file *file,
>   			result = -ENODATA;
>   		}
>   	} else if (buf) {
> -		result = ima_calc_buffer_hash(buf, size, &hash.hdr);
> +		result = ima_calc_buffer_hash(buf, size, hash_hdr);
>   	} else {
> -		result = ima_calc_file_hash(file, &hash.hdr);
> +		result = ima_calc_file_hash(file, hash_hdr);
>   	}
>   
>   	if (result && result != -EBADF && result != -EINVAL)
> diff --git a/security/integrity/ima/ima_appraise.c b/security/integrity/ima/ima_appraise.c
> index 3497741caea9..656c709b974f 100644
> --- a/security/integrity/ima/ima_appraise.c
> +++ b/security/integrity/ima/ima_appraise.c
> @@ -378,7 +378,9 @@ static int xattr_verify(enum ima_hooks func, struct ima_iint_cache *iint,
>   		}
>   
>   		rc = calc_file_id_hash(IMA_VERITY_DIGSIG, iint->ima_hash->algo,
> -				       iint->ima_hash->digest, &hash.hdr);
> +				       iint->ima_hash->digest,
> +				       container_of(&hash.hdr,
> +					       struct ima_digest_data, hdr));
>   		if (rc) {
>   			*cause = "sigv3-hashing-error";
>   			*status = INTEGRITY_FAIL;
> diff --git a/security/integrity/ima/ima_init.c b/security/integrity/ima/ima_init.c
> index 393f5c7912d5..4e208239a40e 100644
> --- a/security/integrity/ima/ima_init.c
> +++ b/security/integrity/ima/ima_init.c
> @@ -48,12 +48,14 @@ static int __init ima_add_boot_aggregate(void)
>   	struct ima_event_data event_data = { .iint = iint,
>   					     .filename = boot_aggregate_name };
>   	struct ima_max_digest_data hash;
> +	struct ima_digest_data *hash_hdr = container_of(&hash.hdr,
> +						struct ima_digest_data, hdr);
>   	int result = -ENOMEM;
>   	int violation = 0;
>   
>   	memset(iint, 0, sizeof(*iint));
>   	memset(&hash, 0, sizeof(hash));
> -	iint->ima_hash = &hash.hdr;
> +	iint->ima_hash = hash_hdr;
>   	iint->ima_hash->algo = ima_hash_algo;
>   	iint->ima_hash->length = hash_digest_size[ima_hash_algo];
>   
> @@ -70,7 +72,7 @@ static int __init ima_add_boot_aggregate(void)
>   	 * is not found.
>   	 */
>   	if (ima_tpm_chip) {
> -		result = ima_calc_boot_aggregate(&hash.hdr);
> +		result = ima_calc_boot_aggregate(hash_hdr);
>   		if (result < 0) {
>   			audit_cause = "hashing_error";
>   			goto err_out;
> diff --git a/security/integrity/ima/ima_main.c b/security/integrity/ima/ima_main.c
> index c84e8c55333d..0d3a7c864fd4 100644
> --- a/security/integrity/ima/ima_main.c
> +++ b/security/integrity/ima/ima_main.c
> @@ -941,6 +941,8 @@ int process_buffer_measurement(struct mnt_idmap *idmap,
>   					    .buf_len = size};
>   	struct ima_template_desc *template;
>   	struct ima_max_digest_data hash;
> +	struct ima_digest_data *hash_hdr = container_of(&hash.hdr,
> +						struct ima_digest_data, hdr);
>   	char digest_hash[IMA_MAX_DIGEST_SIZE];
>   	int digest_hash_len = hash_digest_size[ima_hash_algo];
>   	int violation = 0;
> @@ -979,7 +981,7 @@ int process_buffer_measurement(struct mnt_idmap *idmap,
>   	if (!pcr)
>   		pcr = CONFIG_IMA_MEASURE_PCR_IDX;
>   
> -	iint.ima_hash = &hash.hdr;
> +	iint.ima_hash = hash_hdr;
>   	iint.ima_hash->algo = ima_hash_algo;
>   	iint.ima_hash->length = hash_digest_size[ima_hash_algo];
>   
> @@ -990,7 +992,7 @@ int process_buffer_measurement(struct mnt_idmap *idmap,
>   	}
>   
>   	if (buf_hash) {
> -		memcpy(digest_hash, hash.hdr.digest, digest_hash_len);
> +		memcpy(digest_hash, hash_hdr->digest, digest_hash_len);
>   
>   		ret = ima_calc_buffer_hash(digest_hash, digest_hash_len,
>   					   iint.ima_hash);
> diff --git a/security/integrity/ima/ima_template_lib.c b/security/integrity/ima/ima_template_lib.c
> index 6cd0add524cd..74198d7619da 100644
> --- a/security/integrity/ima/ima_template_lib.c
> +++ b/security/integrity/ima/ima_template_lib.c
> @@ -339,6 +339,8 @@ int ima_eventdigest_init(struct ima_event_data *event_data,
>   			 struct ima_field_data *field_data)
>   {
>   	struct ima_max_digest_data hash;
> +	struct ima_digest_data *hash_hdr = container_of(&hash.hdr,
> +						struct ima_digest_data, hdr);
>   	u8 *cur_digest = NULL;
>   	u32 cur_digestsize = 0;
>   	struct inode *inode;
> @@ -358,7 +360,7 @@ int ima_eventdigest_init(struct ima_event_data *event_data,
>   	if ((const char *)event_data->filename == boot_aggregate_name) {
>   		if (ima_tpm_chip) {
>   			hash.hdr.algo = HASH_ALGO_SHA1;
> -			result = ima_calc_boot_aggregate(&hash.hdr);
> +			result = ima_calc_boot_aggregate(hash_hdr);
>   
>   			/* algo can change depending on available PCR banks */
>   			if (!result && hash.hdr.algo != HASH_ALGO_SHA1)
> @@ -368,7 +370,7 @@ int ima_eventdigest_init(struct ima_event_data *event_data,
>   				memset(&hash, 0, sizeof(hash));
>   		}
>   
> -		cur_digest = hash.hdr.digest;
> +		cur_digest = hash_hdr->digest;
>   		cur_digestsize = hash_digest_size[HASH_ALGO_SHA1];
>   		goto out;
>   	}
> @@ -379,14 +381,14 @@ int ima_eventdigest_init(struct ima_event_data *event_data,
>   	inode = file_inode(event_data->file);
>   	hash.hdr.algo = ima_template_hash_algo_allowed(ima_hash_algo) ?
>   	    ima_hash_algo : HASH_ALGO_SHA1;
> -	result = ima_calc_file_hash(event_data->file, &hash.hdr);
> +	result = ima_calc_file_hash(event_data->file, hash_hdr);
>   	if (result) {
>   		integrity_audit_msg(AUDIT_INTEGRITY_DATA, inode,
>   				    event_data->filename, "collect_data",
>   				    "failed", result, 0);
>   		return result;
>   	}
> -	cur_digest = hash.hdr.digest;
> +	cur_digest = hash_hdr->digest;
>   	cur_digestsize = hash.hdr.length;
>   out:
>   	return ima_eventdigest_init_common(cur_digest, cur_digestsize,
> diff --git a/security/integrity/integrity.h b/security/integrity/integrity.h
> index 50d6f798e613..fc1952da02ea 100644
> --- a/security/integrity/integrity.h
> +++ b/security/integrity/integrity.h
> @@ -44,6 +44,7 @@ struct evm_xattr {
>   #define IMA_MAX_DIGEST_SIZE	HASH_MAX_DIGESTSIZE
>   
>   struct ima_digest_data {
> +	struct_group_tagged(ima_digest_data_hdr, hdr,
>   	u8 algo;
>   	u8 length;
>   	union {
> @@ -57,6 +58,7 @@ struct ima_digest_data {
>   		} ng;
>   		u8 data[2];
>   	} xattr;
> +	);
>   	u8 digest[];
>   } __packed;
>   
> @@ -65,7 +67,7 @@ struct ima_digest_data {
>    * with the maximum hash size, define ima_max_digest_data struct.
>    */
>   struct ima_max_digest_data {
> -	struct ima_digest_data hdr;
> +	struct ima_digest_data_hdr hdr;
>   	u8 digest[HASH_MAX_DIGESTSIZE];
>   } __packed;
>   

