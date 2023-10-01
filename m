Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7D9C37B49A9
	for <lists+linux-kernel@lfdr.de>; Sun,  1 Oct 2023 23:09:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235392AbjJAVJP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 1 Oct 2023 17:09:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45618 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235161AbjJAVJN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 1 Oct 2023 17:09:13 -0400
Received: from domac.alu.hr (domac.alu.unizg.hr [IPv6:2001:b68:2:2800::3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6858EBF
        for <linux-kernel@vger.kernel.org>; Sun,  1 Oct 2023 14:09:08 -0700 (PDT)
Received: from localhost (localhost [127.0.0.1])
        by domac.alu.hr (Postfix) with ESMTP id 7C37E6016E;
        Sun,  1 Oct 2023 23:09:05 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=alu.unizg.hr; s=mail;
        t=1696194545; bh=RTxeCXF/SHfMb7TVdehVfai9tLf5LhMQ2nit2DqfwNM=;
        h=Date:Subject:To:References:From:In-Reply-To:From;
        b=wvqhn0vK8FjPmiKL2psdk6fBWk+vnkIGeaPbasQcI9M0+RImcTXYca/nHzupnkG2/
         dkW5RZAQ5nKcy148Jks30NyvtI7TTOTnWFU7sLODwXtPnUf1Y0kSB3XFMXKAtcE+4A
         TlHyEE0sKS5u9lAfpPdCsKs8ImIylax88TfOp8B4PTV/ooPHyH7QQJSnwZP/KORBlp
         6wEeNUIccRlh2xo4ubPxuABzN9zG72IvOPrBdLVBPahMbb6al/DSmtxtta6gM2GR2v
         osSi/U+fd2RCpxKF35ECPx954/2L8iIN8OkZJozUq2MEznuM4WiPI8DTQ29/1eIZvw
         MS9D/WZLHBjdQ==
X-Virus-Scanned: Debian amavisd-new at domac.alu.hr
Received: from domac.alu.hr ([127.0.0.1])
        by localhost (domac.alu.hr [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id zO_gbJA894pE; Sun,  1 Oct 2023 23:09:02 +0200 (CEST)
Received: from [192.168.1.6] (78-1-184-215.adsl.net.t-com.hr [78.1.184.215])
        by domac.alu.hr (Postfix) with ESMTPSA id DE0A16015F;
        Sun,  1 Oct 2023 23:09:01 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=alu.unizg.hr; s=mail;
        t=1696194542; bh=RTxeCXF/SHfMb7TVdehVfai9tLf5LhMQ2nit2DqfwNM=;
        h=Date:Subject:To:References:From:In-Reply-To:From;
        b=JtRoFBZyDDTbygEPKtzjgKp/XM9P7mRj4VXcRtGQY54bY5We0KPouA1oWYAT54IC4
         j7M6jy490PFvYxsGt3KJ6qw1jAiqTB3kNI2Ew1Vc7mghFbaFudBTzC4vKKfTWh9E5e
         leWcb7HdpoaAvK3x8RbiyBXg+FgieghTv5MkQbKBUTjYmrDgHRa/thplFSFQcXBuXc
         6rx2oytIyJjJ4ItUAXvs1J2iJFOTa+boI7U7QnUoJ0o+SS09VzXpTGPn8khvOzOU2+
         79g6CJuTsbW1BK3nstbLphX0J5Zqk/oDe4tQqUZ8NU8xNVQ5vG69ypNk82Vi4rYxYp
         c10vmBkAXkyuw==
Content-Type: multipart/mixed; boundary="------------NAXGGih7xzJUzK7kosbzdehb"
Message-ID: <5a30110b-2457-4638-8779-baa33326f6a6@alu.unizg.hr>
Date:   Sun, 1 Oct 2023 23:08:56 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: BUG: maple_tree: KCSAN: data-race in mas_topiary_replace /
 mtree_range_walk [EXPERIMENTAL PATCH]
To:     "Liam R. Howlett" <Liam.Howlett@Oracle.com>,
        maple-tree@lists.infradead.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
References: <9c1549f9-78c2-441b-8617-3ea3c080a5a4@alu.unizg.hr>
 <20230922135155.tqrelea66hcj5cog@revolver>
 <5d908c60-88fb-49c0-a150-bfb468eaa513@alu.unizg.hr>
 <20230928195926.ucp7it3c3c75erzk@revolver>
Content-Language: en-US
From:   Mirsad Todorovac <mirsad.todorovac@alu.unizg.hr>
In-Reply-To: <20230928195926.ucp7it3c3c75erzk@revolver>
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------NAXGGih7xzJUzK7kosbzdehb
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 9/28/23 21:59, Liam R. Howlett wrote:
> * Mirsad Todorovac <mirsad.todorovac@alu.unizg.hr> [230923 03:27]:
>> On 9/22/23 15:51, Liam R. Howlett wrote:
> 
> ...
> 
>>>> [ 6413.367326] ==================================================================
>>>> [ 6413.367349] BUG: KCSAN: data-race in mas_topiary_replace / mtree_range_walk
>>>>
>>>> [ 6413.367375] write to 0xffff8883a0c5db00 of 8 bytes by task 5475 on cpu 24:
>>>> [ 6413.367386] mas_topiary_replace (/home/marvin/linux/kernel/torvalds2/lib/maple_tree.c:491 /home/marvin/linux/kernel/torvalds2/lib/maple_tree.c:1701 /home/marvin/linux/kernel/torvalds2/lib/maple_tree.c:2590)
>>>> [ 6413.367399] mas_spanning_rebalance.isra.0 (/home/marvin/linux/kernel/torvalds2/lib/maple_tree.c:2664 /home/marvin/linux/kernel/torvalds2/lib/maple_tree.c:2961)
>>>> [ 6413.367413] mas_wr_spanning_store.isra.0 (/home/marvin/linux/kernel/torvalds2/lib/maple_tree.c:3894)
>>>> [ 6413.367428] mas_wr_store_entry.isra.0 (/home/marvin/linux/kernel/torvalds2/lib/maple_tree.c:4242)
>>>> [ 6413.367442] mas_store_prealloc (/home/marvin/linux/kernel/torvalds2/lib/maple_tree.c:256 /home/marvin/linux/kernel/torvalds2/lib/maple_tree.c:5408)
>>>> [ 6413.367455] vma_merge (/home/marvin/linux/kernel/torvalds2/mm/internal.h:1127 /home/marvin/linux/kernel/torvalds2/mm/mmap.c:1005)
>>>> [ 6413.367466] mprotect_fixup (/home/marvin/linux/kernel/torvalds2/mm/mprotect.c:632)
>>>> [ 6413.367480] do_mprotect_pkey (/home/marvin/linux/kernel/torvalds2/mm/mprotect.c:819)
>>>> [ 6413.367494] __x64_sys_mprotect (/home/marvin/linux/kernel/torvalds2/mm/mprotect.c:837)
>>>> [ 6413.367503] do_syscall_64 (/home/marvin/linux/kernel/torvalds2/arch/x86/entry/common.c:50 /home/marvin/linux/kernel/torvalds2/arch/x86/entry/common.c:80)
>>>> [ 6413.367517] entry_SYSCALL_64_after_hwframe (/home/marvin/linux/kernel/torvalds2/arch/x86/entry/entry_64.S:120)
>>>>
>>>> [ 6413.367534] read to 0xffff8883a0c5db00 of 8 bytes by task 5558 on cpu 11:
>>>> [ 6413.367545] mtree_range_walk (/home/marvin/linux/kernel/torvalds2/lib/maple_tree.c:539 /home/marvin/linux/kernel/torvalds2/lib/maple_tree.c:2789)
>>>> [ 6413.367556] mas_walk (/home/marvin/linux/kernel/torvalds2/lib/maple_tree.c:251 /home/marvin/linux/kernel/torvalds2/lib/maple_tree.c:4844)
>>>> [ 6413.367567] lock_vma_under_rcu (/home/marvin/linux/kernel/torvalds2/mm/memory.c:5436)
>>>> [ 6413.367579] do_user_addr_fault (/home/marvin/linux/kernel/torvalds2/arch/x86/mm/fault.c:1357)
>>>> [ 6413.367593] exc_page_fault (/home/marvin/linux/kernel/torvalds2/./arch/x86/include/asm/paravirt.h:695 /home/marvin/linux/kernel/torvalds2/arch/x86/mm/fault.c:1513 /home/marvin/linux/kernel/torvalds2/arch/x86/mm/fault.c:1561)
>>>> [ 6413.367602] asm_exc_page_fault (/home/marvin/linux/kernel/torvalds2/./arch/x86/include/asm/idtentry.h:570)
>>>>
>>>> [ 6413.367617] value changed: 0xffff888341d43116 -> 0xffff888340f92116
>>>>
>>>> [ 6413.367632] Reported by Kernel Concurrency Sanitizer on:
>>>> [ 6413.367640] CPU: 11 PID: 5558 Comm: ThreadPoolForeg Tainted: G             L     6.6.0-rc2-kcsan-00143-gb5cbe7c00aa0 #41
>>>> [ 6413.367653] Hardware name: ASRock X670E PG Lightning/X670E PG Lightning, BIOS 1.21 04/26/2023
>>>> [ 6413.367660] ==================================================================
>>>>
>>>> For your convenience, took the trouble of finding those suspicious lines of code:
>>>>
>>>> The write side:
>>>>
>>>> lib/maple_tree.c:491
>>>> --------------------
>>>>     456 /*
>>>>     457  * mas_set_parent() - Set the parent node and encode the slot
>>>>     458  * @enode: The encoded maple node.
>>>>     459  * @parent: The encoded maple node that is the parent of @enode.
>>>>     460  * @slot: The slot that @enode resides in @parent.
>>>>     461  *
>>>>     462  * Slot number is encoded in the enode->parent bit 3-6 or 2-6, depending on the
>>>>     463  * parent type.
>>>>     464  */
>>>>     465 static inline
>>>>     466 void mas_set_parent(struct ma_state *mas, struct maple_enode *enode,
>>>>     467                     const struct maple_enode *parent, unsigned char slot)
>>>>     468 {
>>>>     469         unsigned long val = (unsigned long)parent;
>>>>     470         unsigned long shift;
>>>>     471         unsigned long type;
>>>>     472         enum maple_type p_type = mte_node_type(parent);
>>>>     473
>>>>     474         MAS_BUG_ON(mas, p_type == maple_dense);
>>>>     475         MAS_BUG_ON(mas, p_type == maple_leaf_64);
>>>>     476
>>>>     477         switch (p_type) {
>>>>     478         case maple_range_64:
>>>>     479         case maple_arange_64:
>>>>     480                 shift = MAPLE_PARENT_SLOT_SHIFT;
>>>>     481                 type = MAPLE_PARENT_RANGE64;
>>>>     482                 break;
>>>>     483         default:
>>>>     484         case maple_dense:
>>>>     485         case maple_leaf_64:
>>>>     486                 shift = type = 0;
>>>>     487                 break;
>>>>     488         }
>>>>     489
>>>>     490         val &= ~MAPLE_NODE_MASK; /* Clear all node metadata in parent */
>>>> → 491         val |= (slot << shift) | type;
>>>>     492         mte_to_node(enode)->parent = ma_parent_ptr(val);
>>>>     493 }
> 
> This should probably be 492, not 491.  I know what is racing here and it
> shouldn't cause issue.
> 
> ...
>>>> The read side:
>>>>
>>>>      527 /*
>>>>      528  * ma_dead_node() - check if the @enode is dead.
>>>>      529  * @enode: The encoded maple node
>>>>      530  *
>>>>      531  * Return: true if dead, false otherwise.
>>>>      532  */
>>>>      533 static inline bool ma_dead_node(const struct maple_node *node)
>>>>      534 {
>>>>      535         struct maple_node *parent;
>>>>      536
>>>>      537         /* Do not reorder reads from the node prior to the parent check */
>>>>      538         smp_rmb();
>>>> →  539         parent = (void *)((unsigned long) node->parent & ~MAPLE_NODE_MASK);
>>>>      540         return (parent == node);
>>>>      541 }
> 
> This is the correct line.
> 
> ...
>>>>
>>>> as above, but the smb_rmb() protection is here, so the KCSAN warning should be double-checked for
>>>> validity.
>>>>
>>>> But I do not really understand maple trees to their depth, I am only reporting the symptomatic
>>>> outlook of the reported data-race.
>>>
>>> This is the most complex part of the maple tree, and unique to the
>>> ability to store a range over multiple existing entries.  I recently
>>> rewrote this particular section to avoid a potential live-lock issue.
>>
>> I see.
>>
>>> I am confident that the parent pointer will not be set to the node
>>> pointer as checked by ma_dead_node().  But in an abundance of caution
>>> and to resolve this potential false-positive, I am looking at this in
>>> more detail.
>>>
>>> This race is to see if the walk down the tree into unchanged data will
>>> be seen before it is placed in the new subtree with its data also
>>> unchanged.  Since we know the parent can never be the node, I feel this
>>> is safe - but I'm not willing to live with the complaints from kasan.
>>
>> I cannot analyse a couple of thousand lines at such a short notice.
> 
> Don't worry, I will :)
> 
>>
>> It looks suspicious because val in line 491 in a local variable and thus
>> isn't available elsewhere.
> 
> It is used in the node->parent, as described above.  It is a race, but
> it doesn't matter who wins.
> 
>>
>> Maybe the compiler (gcc (Ubuntu 11.4.0-1ubuntu1~22.04) 11.4.0) did something
>> to the code?
> 
> Probably off-by-one line.
> 
>>
>>>> This is all-in-all a very interested subject, and I wish there was a way to just slurp all those
>>>> interesting kernel intrinsics into the brain, but it just ain't that easy. Forgive me for being
>>>> open ...
>>>
>>> I appreciate that and your detailed analysis with code pointers of where
>>> this happens.  Is this easy to recreate?  If so, how?  Can you attach
>>> your kernel config?
>>
>> Got that attached first, so I do not forget. :-/
>>
>> Recreate? Actually it happened quite a number of times on my configuration (480+?).
> 
> I'm having issues recreating it because I hit a lot of races before this
> one in my test setup.  I will keep working on reproducing this race, but
> in the mean time can you test the attached patch with your setup?

They say that one patch speaks more than a thousand words.

I am just running this little patch that actually silences all of the KCSAN warnings.

I cannot tell if these reported data races are the actual bugs, but it is possible that
the Ubuntu 22.04 gcc is doing some funny stuff when optimising. In Prof. McKenney's
book I've read about the load-tearing and store-tearing. AFAICS, memory barriers should
prevent load/store reordering, but not the compiler optimisations.

Please find two versions of the patch attached.

While mas->index and pivots[offset] in maple_range_walk can change concurrently,
I am not smart enough to see whether you expect that in your algorithm or is it a potential
bug triggered by GCC optimisations and aggressive Ryzen 9 7950X parallelism.

This patch is being tested and I am right now writing from a kernel build using this diff v2.
Your patch included.

Best regards,
Mirsad Todorovac

marvin@defiant:~/linux/kernel/torvalds3$ uname -rms
Linux 6.6.0-rc3-kcsan-00230-g8f633369413f-dirty x86_64
marvin@defiant:~/linux/kernel/torvalds3$ git diff | cat -

--------------------------------------------------------------
diff --git a/lib/maple_tree.c b/lib/maple_tree.c
index ee1ff0c59fd7..472ebc43d9fe 100644
--- a/lib/maple_tree.c
+++ b/lib/maple_tree.c
@@ -58,6 +58,7 @@
  #include <linux/slab.h>
  #include <linux/limits.h>
  #include <asm/barrier.h>
+#include <asm/rwonce.h>
  
  #define CREATE_TRACE_POINTS
  #include <trace/events/maple_tree.h>
@@ -301,7 +302,7 @@ static inline struct maple_node *mas_mn(const struct ma_state *mas)
   */
  static inline void mte_set_node_dead(struct maple_enode *mn)
  {
-	mte_to_node(mn)->parent = ma_parent_ptr(mte_to_node(mn));
+	WRITE_ONCE(mte_to_node(mn)->parent, ma_parent_ptr(mte_to_node(mn)));
  	smp_wmb(); /* Needed for RCU */
  }
  
@@ -521,7 +522,7 @@ static inline unsigned int mte_parent_slot(const struct maple_enode *enode)
  static inline struct maple_node *mte_parent(const struct maple_enode *enode)
  {
  	return (void *)((unsigned long)
-			(mte_to_node(enode)->parent) & ~MAPLE_NODE_MASK);
+			(READ_ONCE(mte_to_node(enode)->parent)) & ~MAPLE_NODE_MASK);
  }
  
  /*
@@ -536,7 +537,7 @@ static inline bool ma_dead_node(const struct maple_node *node)
  
  	/* Do not reorder reads from the node prior to the parent check */
  	smp_rmb();
-	parent = (void *)((unsigned long) node->parent & ~MAPLE_NODE_MASK);
+	parent = (void *)((unsigned long) READ_ONCE(node->parent) & ~MAPLE_NODE_MASK);
  	return (parent == node);
  }
  
@@ -1699,6 +1700,7 @@ static inline void mas_adopt_children(struct ma_state *mas,
  	do {
  		child = mas_slot_locked(mas, slots, offset);
  		mas_set_parent(mas, child, parent, offset);
+		smp_wmb(); /* Needed for RCU */
  	} while (offset--);
  }
  
@@ -2775,6 +2777,7 @@ static inline void *mtree_range_walk(struct ma_state *mas)
  	unsigned char end;
  	unsigned long max, min;
  	unsigned long prev_max, prev_min;
+	unsigned long my_pivot, mas_index;
  
  	next = mas->node;
  	min = mas->min;
@@ -2789,22 +2792,27 @@ static inline void *mtree_range_walk(struct ma_state *mas)
  		if (unlikely(ma_dead_node(node)))
  			goto dead_node;
  
-		if (pivots[offset] >= mas->index) {
+		my_pivot = READ_ONCE(pivots[offset]);
+		mas_index = READ_ONCE(mas->index);
+
+		if (my_pivot >= mas_index) {
  			prev_max = max;
  			prev_min = min;
-			max = pivots[offset];
+			max = my_pivot;
  			goto next;
  		}
  
  		do {
  			offset++;
-		} while ((offset < end) && (pivots[offset] < mas->index));
+			my_pivot = READ_ONCE(pivots[offset]);
+		} while ((offset < end) && (my_pivot < mas_index));
  
  		prev_min = min;
-		min = pivots[offset - 1] + 1;
+		min = READ_ONCE(pivots[offset - 1]) + 1;
  		prev_max = max;
-		if (likely(offset < end && pivots[offset]))
-			max = pivots[offset];
+
+		if (likely(offset < end && my_pivot))
+			max = my_pivot;
  
  next:
  		slots = ma_slots(node, type);
marvin@defiant:~/linux/kernel/torvalds3$

--------------NAXGGih7xzJUzK7kosbzdehb
Content-Type: text/x-patch; charset=UTF-8; name="maple-cummulative-v2.diff"
Content-Disposition: attachment; filename="maple-cummulative-v2.diff"
Content-Transfer-Encoding: base64

ZGlmZiAtLWdpdCBhL2xpYi9tYXBsZV90cmVlLmMgYi9saWIvbWFwbGVfdHJlZS5jCmluZGV4
IGVlMWZmMGM1OWZkNy4uNDcyZWJjNDNkOWZlIDEwMDY0NAotLS0gYS9saWIvbWFwbGVfdHJl
ZS5jCisrKyBiL2xpYi9tYXBsZV90cmVlLmMKQEAgLTU4LDYgKzU4LDcgQEAKICNpbmNsdWRl
IDxsaW51eC9zbGFiLmg+CiAjaW5jbHVkZSA8bGludXgvbGltaXRzLmg+CiAjaW5jbHVkZSA8
YXNtL2JhcnJpZXIuaD4KKyNpbmNsdWRlIDxhc20vcndvbmNlLmg+CiAKICNkZWZpbmUgQ1JF
QVRFX1RSQUNFX1BPSU5UUwogI2luY2x1ZGUgPHRyYWNlL2V2ZW50cy9tYXBsZV90cmVlLmg+
CkBAIC0zMDEsNyArMzAyLDcgQEAgc3RhdGljIGlubGluZSBzdHJ1Y3QgbWFwbGVfbm9kZSAq
bWFzX21uKGNvbnN0IHN0cnVjdCBtYV9zdGF0ZSAqbWFzKQogICovCiBzdGF0aWMgaW5saW5l
IHZvaWQgbXRlX3NldF9ub2RlX2RlYWQoc3RydWN0IG1hcGxlX2Vub2RlICptbikKIHsKLQlt
dGVfdG9fbm9kZShtbiktPnBhcmVudCA9IG1hX3BhcmVudF9wdHIobXRlX3RvX25vZGUobW4p
KTsKKwlXUklURV9PTkNFKG10ZV90b19ub2RlKG1uKS0+cGFyZW50LCBtYV9wYXJlbnRfcHRy
KG10ZV90b19ub2RlKG1uKSkpOwogCXNtcF93bWIoKTsgLyogTmVlZGVkIGZvciBSQ1UgKi8K
IH0KIApAQCAtNTIxLDcgKzUyMiw3IEBAIHN0YXRpYyBpbmxpbmUgdW5zaWduZWQgaW50IG10
ZV9wYXJlbnRfc2xvdChjb25zdCBzdHJ1Y3QgbWFwbGVfZW5vZGUgKmVub2RlKQogc3RhdGlj
IGlubGluZSBzdHJ1Y3QgbWFwbGVfbm9kZSAqbXRlX3BhcmVudChjb25zdCBzdHJ1Y3QgbWFw
bGVfZW5vZGUgKmVub2RlKQogewogCXJldHVybiAodm9pZCAqKSgodW5zaWduZWQgbG9uZykK
LQkJCShtdGVfdG9fbm9kZShlbm9kZSktPnBhcmVudCkgJiB+TUFQTEVfTk9ERV9NQVNLKTsK
KwkJCShSRUFEX09OQ0UobXRlX3RvX25vZGUoZW5vZGUpLT5wYXJlbnQpKSAmIH5NQVBMRV9O
T0RFX01BU0spOwogfQogCiAvKgpAQCAtNTM2LDcgKzUzNyw3IEBAIHN0YXRpYyBpbmxpbmUg
Ym9vbCBtYV9kZWFkX25vZGUoY29uc3Qgc3RydWN0IG1hcGxlX25vZGUgKm5vZGUpCiAKIAkv
KiBEbyBub3QgcmVvcmRlciByZWFkcyBmcm9tIHRoZSBub2RlIHByaW9yIHRvIHRoZSBwYXJl
bnQgY2hlY2sgKi8KIAlzbXBfcm1iKCk7Ci0JcGFyZW50ID0gKHZvaWQgKikoKHVuc2lnbmVk
IGxvbmcpIG5vZGUtPnBhcmVudCAmIH5NQVBMRV9OT0RFX01BU0spOworCXBhcmVudCA9ICh2
b2lkICopKCh1bnNpZ25lZCBsb25nKSBSRUFEX09OQ0Uobm9kZS0+cGFyZW50KSAmIH5NQVBM
RV9OT0RFX01BU0spOwogCXJldHVybiAocGFyZW50ID09IG5vZGUpOwogfQogCkBAIC0xNjk5
LDYgKzE3MDAsNyBAQCBzdGF0aWMgaW5saW5lIHZvaWQgbWFzX2Fkb3B0X2NoaWxkcmVuKHN0
cnVjdCBtYV9zdGF0ZSAqbWFzLAogCWRvIHsKIAkJY2hpbGQgPSBtYXNfc2xvdF9sb2NrZWQo
bWFzLCBzbG90cywgb2Zmc2V0KTsKIAkJbWFzX3NldF9wYXJlbnQobWFzLCBjaGlsZCwgcGFy
ZW50LCBvZmZzZXQpOworCQlzbXBfd21iKCk7IC8qIE5lZWRlZCBmb3IgUkNVICovCiAJfSB3
aGlsZSAob2Zmc2V0LS0pOwogfQogCkBAIC0yNzc1LDYgKzI3NzcsNyBAQCBzdGF0aWMgaW5s
aW5lIHZvaWQgKm10cmVlX3JhbmdlX3dhbGsoc3RydWN0IG1hX3N0YXRlICptYXMpCiAJdW5z
aWduZWQgY2hhciBlbmQ7CiAJdW5zaWduZWQgbG9uZyBtYXgsIG1pbjsKIAl1bnNpZ25lZCBs
b25nIHByZXZfbWF4LCBwcmV2X21pbjsKKwl1bnNpZ25lZCBsb25nIG15X3Bpdm90LCBtYXNf
aW5kZXg7CiAKIAluZXh0ID0gbWFzLT5ub2RlOwogCW1pbiA9IG1hcy0+bWluOwpAQCAtMjc4
OSwyMiArMjc5MiwyNyBAQCBzdGF0aWMgaW5saW5lIHZvaWQgKm10cmVlX3JhbmdlX3dhbGso
c3RydWN0IG1hX3N0YXRlICptYXMpCiAJCWlmICh1bmxpa2VseShtYV9kZWFkX25vZGUobm9k
ZSkpKQogCQkJZ290byBkZWFkX25vZGU7CiAKLQkJaWYgKHBpdm90c1tvZmZzZXRdID49IG1h
cy0+aW5kZXgpIHsKKwkJbXlfcGl2b3QgPSBSRUFEX09OQ0UocGl2b3RzW29mZnNldF0pOwor
CQltYXNfaW5kZXggPSBSRUFEX09OQ0UobWFzLT5pbmRleCk7CisKKwkJaWYgKG15X3Bpdm90
ID49IG1hc19pbmRleCkgewogCQkJcHJldl9tYXggPSBtYXg7CiAJCQlwcmV2X21pbiA9IG1p
bjsKLQkJCW1heCA9IHBpdm90c1tvZmZzZXRdOworCQkJbWF4ID0gbXlfcGl2b3Q7CiAJCQln
b3RvIG5leHQ7CiAJCX0KIAogCQlkbyB7CiAJCQlvZmZzZXQrKzsKLQkJfSB3aGlsZSAoKG9m
ZnNldCA8IGVuZCkgJiYgKHBpdm90c1tvZmZzZXRdIDwgbWFzLT5pbmRleCkpOworCQkJbXlf
cGl2b3QgPSBSRUFEX09OQ0UocGl2b3RzW29mZnNldF0pOworCQl9IHdoaWxlICgob2Zmc2V0
IDwgZW5kKSAmJiAobXlfcGl2b3QgPCBtYXNfaW5kZXgpKTsKIAogCQlwcmV2X21pbiA9IG1p
bjsKLQkJbWluID0gcGl2b3RzW29mZnNldCAtIDFdICsgMTsKKwkJbWluID0gUkVBRF9PTkNF
KHBpdm90c1tvZmZzZXQgLSAxXSkgKyAxOwogCQlwcmV2X21heCA9IG1heDsKLQkJaWYgKGxp
a2VseShvZmZzZXQgPCBlbmQgJiYgcGl2b3RzW29mZnNldF0pKQotCQkJbWF4ID0gcGl2b3Rz
W29mZnNldF07CisKKwkJaWYgKGxpa2VseShvZmZzZXQgPCBlbmQgJiYgbXlfcGl2b3QpKQor
CQkJbWF4ID0gbXlfcGl2b3Q7CiAKIG5leHQ6CiAJCXNsb3RzID0gbWFfc2xvdHMobm9kZSwg
dHlwZSk7Cg==
--------------NAXGGih7xzJUzK7kosbzdehb
Content-Type: text/x-patch; charset=UTF-8; name="maple-cummulative.diff"
Content-Disposition: attachment; filename="maple-cummulative.diff"
Content-Transfer-Encoding: base64

ZGlmZiAtLWdpdCBhL2xpYi9tYXBsZV90cmVlLmMgYi9saWIvbWFwbGVfdHJlZS5jCmluZGV4
IGVlMWZmMGM1OWZkNy4uYzliMmQ1ZmMxYzZhIDEwMDY0NAotLS0gYS9saWIvbWFwbGVfdHJl
ZS5jCisrKyBiL2xpYi9tYXBsZV90cmVlLmMKQEAgLTU4LDYgKzU4LDcgQEAKICNpbmNsdWRl
IDxsaW51eC9zbGFiLmg+CiAjaW5jbHVkZSA8bGludXgvbGltaXRzLmg+CiAjaW5jbHVkZSA8
YXNtL2JhcnJpZXIuaD4KKyNpbmNsdWRlIDxhc20vcndvbmNlLmg+CiAKICNkZWZpbmUgQ1JF
QVRFX1RSQUNFX1BPSU5UUwogI2luY2x1ZGUgPHRyYWNlL2V2ZW50cy9tYXBsZV90cmVlLmg+
CkBAIC0zMDEsNyArMzAyLDcgQEAgc3RhdGljIGlubGluZSBzdHJ1Y3QgbWFwbGVfbm9kZSAq
bWFzX21uKGNvbnN0IHN0cnVjdCBtYV9zdGF0ZSAqbWFzKQogICovCiBzdGF0aWMgaW5saW5l
IHZvaWQgbXRlX3NldF9ub2RlX2RlYWQoc3RydWN0IG1hcGxlX2Vub2RlICptbikKIHsKLQlt
dGVfdG9fbm9kZShtbiktPnBhcmVudCA9IG1hX3BhcmVudF9wdHIobXRlX3RvX25vZGUobW4p
KTsKKwlXUklURV9PTkNFKG10ZV90b19ub2RlKG1uKS0+cGFyZW50LCBtYV9wYXJlbnRfcHRy
KG10ZV90b19ub2RlKG1uKSkpOwogCXNtcF93bWIoKTsgLyogTmVlZGVkIGZvciBSQ1UgKi8K
IH0KIApAQCAtNTIxLDcgKzUyMiw3IEBAIHN0YXRpYyBpbmxpbmUgdW5zaWduZWQgaW50IG10
ZV9wYXJlbnRfc2xvdChjb25zdCBzdHJ1Y3QgbWFwbGVfZW5vZGUgKmVub2RlKQogc3RhdGlj
IGlubGluZSBzdHJ1Y3QgbWFwbGVfbm9kZSAqbXRlX3BhcmVudChjb25zdCBzdHJ1Y3QgbWFw
bGVfZW5vZGUgKmVub2RlKQogewogCXJldHVybiAodm9pZCAqKSgodW5zaWduZWQgbG9uZykK
LQkJCShtdGVfdG9fbm9kZShlbm9kZSktPnBhcmVudCkgJiB+TUFQTEVfTk9ERV9NQVNLKTsK
KwkJCShSRUFEX09OQ0UobXRlX3RvX25vZGUoZW5vZGUpLT5wYXJlbnQpKSAmIH5NQVBMRV9O
T0RFX01BU0spOwogfQogCiAvKgpAQCAtNTM2LDcgKzUzNyw3IEBAIHN0YXRpYyBpbmxpbmUg
Ym9vbCBtYV9kZWFkX25vZGUoY29uc3Qgc3RydWN0IG1hcGxlX25vZGUgKm5vZGUpCiAKIAkv
KiBEbyBub3QgcmVvcmRlciByZWFkcyBmcm9tIHRoZSBub2RlIHByaW9yIHRvIHRoZSBwYXJl
bnQgY2hlY2sgKi8KIAlzbXBfcm1iKCk7Ci0JcGFyZW50ID0gKHZvaWQgKikoKHVuc2lnbmVk
IGxvbmcpIG5vZGUtPnBhcmVudCAmIH5NQVBMRV9OT0RFX01BU0spOworCXBhcmVudCA9ICh2
b2lkICopKCh1bnNpZ25lZCBsb25nKSBSRUFEX09OQ0Uobm9kZS0+cGFyZW50KSAmIH5NQVBM
RV9OT0RFX01BU0spOwogCXJldHVybiAocGFyZW50ID09IG5vZGUpOwogfQogCkBAIC0xNjk5
LDYgKzE3MDAsNyBAQCBzdGF0aWMgaW5saW5lIHZvaWQgbWFzX2Fkb3B0X2NoaWxkcmVuKHN0
cnVjdCBtYV9zdGF0ZSAqbWFzLAogCWRvIHsKIAkJY2hpbGQgPSBtYXNfc2xvdF9sb2NrZWQo
bWFzLCBzbG90cywgb2Zmc2V0KTsKIAkJbWFzX3NldF9wYXJlbnQobWFzLCBjaGlsZCwgcGFy
ZW50LCBvZmZzZXQpOworCQlzbXBfd21iKCk7IC8qIE5lZWRlZCBmb3IgUkNVICovCiAJfSB3
aGlsZSAob2Zmc2V0LS0pOwogfQogCkBAIC0yNzc1LDYgKzI3NzcsNyBAQCBzdGF0aWMgaW5s
aW5lIHZvaWQgKm10cmVlX3JhbmdlX3dhbGsoc3RydWN0IG1hX3N0YXRlICptYXMpCiAJdW5z
aWduZWQgY2hhciBlbmQ7CiAJdW5zaWduZWQgbG9uZyBtYXgsIG1pbjsKIAl1bnNpZ25lZCBs
b25nIHByZXZfbWF4LCBwcmV2X21pbjsKKwl1bnNpZ25lZCBsb25nIG15cGl2b3Q7CiAKIAlu
ZXh0ID0gbWFzLT5ub2RlOwogCW1pbiA9IG1hcy0+bWluOwpAQCAtMjc4OSwyMiArMjc5Miwy
NSBAQCBzdGF0aWMgaW5saW5lIHZvaWQgKm10cmVlX3JhbmdlX3dhbGsoc3RydWN0IG1hX3N0
YXRlICptYXMpCiAJCWlmICh1bmxpa2VseShtYV9kZWFkX25vZGUobm9kZSkpKQogCQkJZ290
byBkZWFkX25vZGU7CiAKLQkJaWYgKHBpdm90c1tvZmZzZXRdID49IG1hcy0+aW5kZXgpIHsK
KwkJbXlwaXZvdCA9IFJFQURfT05DRShwaXZvdHNbb2Zmc2V0XSk7CisJCWlmIChteXBpdm90
ID49IFJFQURfT05DRShtYXMtPmluZGV4KSkgewogCQkJcHJldl9tYXggPSBtYXg7CiAJCQlw
cmV2X21pbiA9IG1pbjsKLQkJCW1heCA9IHBpdm90c1tvZmZzZXRdOworCQkJbWF4ID0gbXlw
aXZvdDsKIAkJCWdvdG8gbmV4dDsKIAkJfQogCiAJCWRvIHsKIAkJCW9mZnNldCsrOwotCQl9
IHdoaWxlICgob2Zmc2V0IDwgZW5kKSAmJiAocGl2b3RzW29mZnNldF0gPCBtYXMtPmluZGV4
KSk7CisJCX0gd2hpbGUgKChvZmZzZXQgPCBlbmQpICYmIChSRUFEX09OQ0UocGl2b3RzW29m
ZnNldF0pIDwgUkVBRF9PTkNFKG1hcy0+aW5kZXgpKSk7CiAKIAkJcHJldl9taW4gPSBtaW47
Ci0JCW1pbiA9IHBpdm90c1tvZmZzZXQgLSAxXSArIDE7CisJCW1pbiA9IFJFQURfT05DRShw
aXZvdHNbb2Zmc2V0IC0gMV0pICsgMTsKIAkJcHJldl9tYXggPSBtYXg7Ci0JCWlmIChsaWtl
bHkob2Zmc2V0IDwgZW5kICYmIHBpdm90c1tvZmZzZXRdKSkKLQkJCW1heCA9IHBpdm90c1tv
ZmZzZXRdOworCisJCW15cGl2b3QgPSBSRUFEX09OQ0UocGl2b3RzW29mZnNldF0pOworCQlp
ZiAobGlrZWx5KG9mZnNldCA8IGVuZCAmJiBteXBpdm90KSkKKwkJCW1heCA9IG15cGl2b3Q7
CiAKIG5leHQ6CiAJCXNsb3RzID0gbWFfc2xvdHMobm9kZSwgdHlwZSk7Cg==

--------------NAXGGih7xzJUzK7kosbzdehb--
