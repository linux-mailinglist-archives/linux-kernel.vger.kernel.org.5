Return-Path: <linux-kernel+bounces-48774-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DBBCA846105
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Feb 2024 20:34:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 920DA28FBC7
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Feb 2024 19:34:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E1F5A85288;
	Thu,  1 Feb 2024 19:34:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="R0SsYqXy"
Received: from mail-qt1-f169.google.com (mail-qt1-f169.google.com [209.85.160.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 070B284FCF
	for <linux-kernel@vger.kernel.org>; Thu,  1 Feb 2024 19:34:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706816073; cv=none; b=JD+alTRzUVuHiAuFedlxDegtCqPOojWcnwi9bOhRBG7Nkwc4M9rBeHzMmq0kUdOQSmmLSN2dXjX4HDMj0pEFh0/kboDeKnoTcMrGJ+HVd2WYpWTwIu5XGDnww4UqNhG6PSUM9UKbpmJrPHZtqXj0VoKO++F3JGAUKQiXceNsn9U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706816073; c=relaxed/simple;
	bh=azrHQn5NRzloniAve6lH8WYk89pATs5I0qI/dcR5hT0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ArjZeVtZReDqRMfIis5HRWJBikxIjTyn0tlneitHhG4n11wKN7GzhRG9VK+hE+oBf8btmVAxpCjNuxF9Ij77XtheB/FHs9/OBwS9pbmaWdg9/9l+2rZpMK26dfZnE8LBIpIUZJLuFuwQeQJ71NGxdBHLvAefWjy6HJLXPiO50TI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=R0SsYqXy; arc=none smtp.client-ip=209.85.160.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Received: by mail-qt1-f169.google.com with SMTP id d75a77b69052e-42aabb1cdaaso9984711cf.2
        for <linux-kernel@vger.kernel.org>; Thu, 01 Feb 2024 11:34:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1706816069; x=1707420869; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=27QC2KxXWf1pwp+Uy5SzOL0al7IZt0TnuDDgoIUMSOo=;
        b=R0SsYqXydKzxQgNWd1bG3V9t/6K0eBG0tDK13+3R5xYapUx16sFftURbblkXx3LOY0
         P4pgGtU0s/2093N2q1hj98H24BSq1QhXcXfTEuTwTsWExsuf6fnFERzan8YhCe7eWfS2
         CvpiEIjG8lXmSVnIBk57wFqDNDemuAeBbxY+WPfGif1gLzDer5/JIvZPkzX2yg54sJG+
         uNU3ivcGsKpmx+AlHt20Tw3KRcWlvgizBifEEutKli+3bgKWM8hHTU1as1HC1ZIbqNdj
         dEo/vPqq0LF0xYTayEPvH61BbNeSSqSVAmkRsnh2sjt8ZS434sVjANiPIYa4vcNVZY37
         d4Og==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706816069; x=1707420869;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=27QC2KxXWf1pwp+Uy5SzOL0al7IZt0TnuDDgoIUMSOo=;
        b=vFfBT7B1gauU8BmkLpW/sWBP7WdfVsyK/N8N1hA9QBRgI/bkwGSXJfe57o6RJZTm/v
         TD8upVnNYPev55oYPLny2NJsu0B6tyyNrcinTsGeeCfEjaPkWkMzAKx2tH7T+kbGW7UM
         AOUf9J5wpLKIjF6kY/YeUWeqYL4U+YqulsScUM2l+bly+D/d40cnKrQcaywQ5bV+6z0q
         8gXxfi/1MYDVCTavkm4YXdDmhLgHzq73NmfaRUBQ6SXihBl4MB78W8+8bF/9B88enOXI
         lVcebCWDEdz0K99swZTYclkn0oHYh9a4ezIuspLW2TivhkukPk2nL9f8GuIjFdZSKm86
         dzvQ==
X-Gm-Message-State: AOJu0YxL5OFoEjnwzfbly107oIzsy+ALSw53Q6qn25ab15clbkR8qyt8
	Vv8msWZ/oJ+t9iBxYP9xzFyOSlh6Zfo8NOzFjxHi8dlcbMyXcYIHayhsWXgxHwQ=
X-Google-Smtp-Source: AGHT+IFJvj4DtYD8GbuWKqJRSEbmY0qhb1v/YCGOdt98bAnNJl49tIasu3xQLSRVIi4ugxyxoKbq3g==
X-Received: by 2002:a05:6214:f63:b0:68c:7f6f:2d9 with SMTP id iy3-20020a0562140f6300b0068c7f6f02d9mr3180586qvb.6.1706816068946;
        Thu, 01 Feb 2024 11:34:28 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCUOTKhvn23O8MoIzJe4VL2yxzCphW1meyPvWhVVaDhxZ2f4PKX7FWacO5zfm7VIbsjDCCGckv6IRbNc85dURbbjvUMZCiAlif3X3IvQ9vZLauO8zZknxh1HewOfUL9yKrmMN4kdwNdaChP5xKKLvwt/yC2Qm+p48Youy3MWY1xmbdsKaGYAml+JtvAq86ICgr80GNL//qKUtXI+NTuw+9FSAz7M+C+FeyMy3Xz7iHO4Qnv4XBSXn1btWfHcS4i3WBsiuwhBZAYRWMouS38wLuhPoD7R5rYvqPNEDqn0N7oUau0HK4UlfiIW+GEeIIiBhuwqbcehauiTZ/QctutL871fY5D4dGZ6AxI/kw==
Received: from ziepe.ca (hlfxns017vw-142-68-80-239.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.68.80.239])
        by smtp.gmail.com with ESMTPSA id mz9-20020a0562142d0900b0068c4b6000ccsm61796qvb.121.2024.02.01.11.34.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Feb 2024 11:34:28 -0800 (PST)
Received: from jgg by wakko with local (Exim 4.95)
	(envelope-from <jgg@ziepe.ca>)
	id 1rVcpP-00AoUU-Ju;
	Thu, 01 Feb 2024 15:34:27 -0400
Date: Thu, 1 Feb 2024 15:34:27 -0400
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Baolu Lu <baolu.lu@linux.intel.com>
Cc: Ethan Zhao <haifeng.zhao@linux.intel.com>,
	"Tian, Kevin" <kevin.tian@intel.com>,
	"Liu, Yi L" <yi.l.liu@intel.com>,
	"bhelgaas@google.com" <bhelgaas@google.com>,
	"robin.murphy@arm.com" <robin.murphy@arm.com>,
	"dwmw2@infradead.org" <dwmw2@infradead.org>,
	"will@kernel.org" <will@kernel.org>,
	"lukas@wunner.de" <lukas@wunner.de>,
	"iommu@lists.linux.dev" <iommu@lists.linux.dev>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>
Subject: Re: [PATCH v12 5/5] iommu/vt-d: improve ITE fault handling if target
 device isn't present
Message-ID: <20240201193427.GQ50608@ziepe.ca>
References: <20240129034924.817005-1-haifeng.zhao@linux.intel.com>
 <20240129034924.817005-6-haifeng.zhao@linux.intel.com>
 <BN9PR11MB52761CC3E5F08D4B7BAD7F918C7E2@BN9PR11MB5276.namprd11.prod.outlook.com>
 <7adec292-9d38-41ab-a982-bd840b24f3ab@intel.com>
 <0aee453c-e98f-4b72-8107-31d4731abcdb@linux.intel.com>
 <BN9PR11MB5276D3372267CE9246170FA78C7D2@BN9PR11MB5276.namprd11.prod.outlook.com>
 <500c4582-ec05-4a9e-9b68-d2ae19aed49b@linux.intel.com>
 <20240130162958.GF50608@ziepe.ca>
 <6a48f023-2701-4f2f-8077-14fe348794dd@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6a48f023-2701-4f2f-8077-14fe348794dd@linux.intel.com>

On Wed, Jan 31, 2024 at 02:21:20PM +0800, Baolu Lu wrote:
> An rbtree for IOMMU device data for the VT-d driver would be beneficial.
> It also benefits other paths of fault handling, such as the I/O page
> fault handling path, where it currently still relies on the PCI
> subsystem to convert a RID value into a pci_device structure.
> 
> Given that such an rbtree would be helpful for multiple individual
> drivers that handle PCI devices, it seems valuable to implement it in
> the core?

rbtree is already supposed to be a re-usable library.

There is already good helper support in rbtree to make things easy to
implement. I see arm hasn't used them yet, it should look something
like this:

diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
index f58e77b99d476b..ebf86c6a8787c4 100644
--- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
+++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
@@ -1673,26 +1673,37 @@ static int arm_smmu_init_l2_strtab(struct arm_smmu_device *smmu, u32 sid)
 	return 0;
 }
 
+static int arm_smmu_streams_cmp_key(const void *lhs, const struct rb_node *rhs)
+{
+	struct arm_smmu_stream *stream_rhs =
+		rb_entry(rhs, struct arm_smmu_stream, node);
+	const u32 *sid_lhs = lhs;
+
+	if (*sid_lhs < stream_rhs->id)
+		return -1;
+	if (*sid_lhs > stream_rhs->id)
+		return 1;
+	return 0;
+}
+
+static int arm_smmu_streams_cmp_node(struct rb_node *lhs,
+				     const struct rb_node *rhs)
+{
+	return arm_smmu_streams_cmp_key(
+		&rb_entry(lhs, struct arm_smmu_stream, node)->id, rhs);
+}
+
 static struct arm_smmu_master *
 arm_smmu_find_master(struct arm_smmu_device *smmu, u32 sid)
 {
 	struct rb_node *node;
-	struct arm_smmu_stream *stream;
 
 	lockdep_assert_held(&smmu->streams_mutex);
 
-	node = smmu->streams.rb_node;
-	while (node) {
-		stream = rb_entry(node, struct arm_smmu_stream, node);
-		if (stream->id < sid)
-			node = node->rb_right;
-		else if (stream->id > sid)
-			node = node->rb_left;
-		else
-			return stream->master;
-	}
-
-	return NULL;
+	node = rb_find(&sid, &smmu->streams, arm_smmu_streams_cmp_key);
+	if (!node)
+		return NULL;
+	return rb_entry(node, struct arm_smmu_stream, node)->master;
 }
 
 /* IRQ and event handlers */
@@ -3324,8 +3335,6 @@ static int arm_smmu_insert_master(struct arm_smmu_device *smmu,
 {
 	int i;
 	int ret = 0;
-	struct arm_smmu_stream *new_stream, *cur_stream;
-	struct rb_node **new_node, *parent_node = NULL;
 	struct iommu_fwspec *fwspec = dev_iommu_fwspec_get(master->dev);
 
 	master->streams = kcalloc(fwspec->num_ids, sizeof(*master->streams),
@@ -3336,6 +3345,7 @@ static int arm_smmu_insert_master(struct arm_smmu_device *smmu,
 
 	mutex_lock(&smmu->streams_mutex);
 	for (i = 0; i < fwspec->num_ids; i++) {
+		struct arm_smmu_stream *new_stream;
 		u32 sid = fwspec->ids[i];
 
 		new_stream = &master->streams[i];
@@ -3347,28 +3357,13 @@ static int arm_smmu_insert_master(struct arm_smmu_device *smmu,
 			break;
 
 		/* Insert into SID tree */
-		new_node = &(smmu->streams.rb_node);
-		while (*new_node) {
-			cur_stream = rb_entry(*new_node, struct arm_smmu_stream,
-					      node);
-			parent_node = *new_node;
-			if (cur_stream->id > new_stream->id) {
-				new_node = &((*new_node)->rb_left);
-			} else if (cur_stream->id < new_stream->id) {
-				new_node = &((*new_node)->rb_right);
-			} else {
-				dev_warn(master->dev,
-					 "stream %u already in tree\n",
-					 cur_stream->id);
-				ret = -EINVAL;
-				break;
-			}
-		}
-		if (ret)
+		if (rb_find_add(&new_stream->node, &smmu->streams,
+				arm_smmu_streams_cmp_node)) {
+			dev_warn(master->dev, "stream %u already in tree\n",
+				 sid);
+			ret = -EINVAL;
 			break;
-
-		rb_link_node(&new_stream->node, parent_node, new_node);
-		rb_insert_color(&new_stream->node, &smmu->streams);
+		}
 	}
 
 	if (ret) {

